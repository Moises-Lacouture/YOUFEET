import SwiftUI
import ARKit
import Foundation
import simd

class ScanViewModel: ObservableObject {
    @Published var meshCount: Int = 0
    @Published var groundPlane: Bool = false
    @Published var scanning: Bool = false
    @Published var message: String = "Point Camera at the floor"
    @Published var measurements: FootMeasurements?
    @Published var showResults: Bool = false
    
    private var collectedVertices: [SIMD3<Float>] = []
    private var groundY: Float?
    private var shoeCenter: SIMD3<Float>?
    
    func addMesh(vertices: [SIMD3<Float>]) {
        guard scanning else { return }
        guard vertices.count > 10 else { return }
        
        var nonFloorVertices = vertices
        if let groundY = groundY {
            let minDistanceFromFloor: Float = 0.005
            nonFloorVertices = vertices.filter { ($0.y - groundY) > minDistanceFromFloor }
            if nonFloorVertices.count < 5 { return }
        }
        
        guard let minX = nonFloorVertices.map({ $0.x }).min(),
              let maxX = nonFloorVertices.map({ $0.x }).max(),
              let minZ = nonFloorVertices.map({ $0.z }).min(),
              let maxZ = nonFloorVertices.map({ $0.z }).max() else { return }
        
        let lengthCM = Double(abs(maxZ - minZ) * 100.0)
        let widthCM = Double(abs(maxX - minX) * 100.0)
        
        if lengthCM > 80 || widthCM > 80 { return }
        if lengthCM < 3 || widthCM < 3 { return }
        
        let sum = nonFloorVertices.reduce(SIMD3<Float>(repeating: 0)) { $0 + $1 }
        let center = sum / Float(nonFloorVertices.count)
        
        if let shoeCenter = shoeCenter {
            let dx = center.x - shoeCenter.x
            let dz = center.z - shoeCenter.z
            if sqrt(dx*dx + dz*dz) > 0.30 { return }
        } else {
            shoeCenter = center
        }
        
        meshCount += 1
        collectedVertices.append(contentsOf: nonFloorVertices)
        updateStat()
    }
    
    func foundGroundPlane(at transform: simd_float4x4) {
        if !groundPlane {
            groundPlane = true
            groundY = transform.columns.3.y
            updateStat()
        }
    }
    
    func scanStarted() {
        meshCount = 0
        scanning = true
        groundPlane = false
        showResults = false
        measurements = nil
        message = "Point Camera at the floor"
        groundY = nil
        shoeCenter = nil
        collectedVertices.removeAll()
    }
    
    func scanFinished(footSide: FootSide) {
        scanning = false
        
        guard meshCount >= 3 else {
            message = "Not enough data. Try again."
            return
        }
        
        guard let result = computeMeasurements(footSide: footSide) else {
            message = "Could not calculate. Try again."
            return
        }
        
        measurements = result
        showResults = true
    }
    
    private func updateStat() {
        if !groundPlane {
            message = "Point camera at the floor"
        } else if meshCount == 0 {
            message = "Ground detected! Scan your foot"
        } else if meshCount < 5 {
            message = "Scanning... move slowly around"
        } else {
            message = "\(meshCount) sections captured"
        }
    }
    
    private func computeMeasurements(footSide: FootSide) -> FootMeasurements? {
        var vertices = collectedVertices
        
        guard vertices.count > 50 else { return nil }
        
        if let groundY = groundY {
            vertices = vertices.filter {
                let dy = $0.y - groundY
                return dy > 0.0 && dy < 0.30
            }
        }
        
        guard vertices.count > 30 else { return nil }
        
        let n = Double(vertices.count)
        guard n >= 2 else { return nil }
        
        var meanX: Double = 0, meanZ: Double = 0
        for v in vertices { meanX += Double(v.x); meanZ += Double(v.z) }
        meanX /= n; meanZ /= n
        
        var covXX: Double = 0, covZZ: Double = 0, covXZ: Double = 0
        for v in vertices {
            let dx = Double(v.x) - meanX
            let dz = Double(v.z) - meanZ
            covXX += dx * dx; covZZ += dz * dz; covXZ += dx * dz
        }
        covXX /= n; covZZ /= n; covXZ /= n
        
        let trace = covXX + covZZ
        let det = covXX * covZZ - covXZ * covXZ
        let temp = sqrt(max(0.0, trace * trace / 4.0 - det))
        let lambda1 = trace / 2.0 + temp
        
        var major = SIMD2<Double>(covXZ, lambda1 - covXX)
        let norm = sqrt(major.x * major.x + major.y * major.y)
        if norm < 1e-8 { major = SIMD2<Double>(1.0, 0.0) } else { major /= norm }
        let minor = SIMD2<Double>(-major.y, major.x)
        
        var minS = Double.greatestFiniteMagnitude, maxS = -Double.greatestFiniteMagnitude
        var minT = Double.greatestFiniteMagnitude, maxT = -Double.greatestFiniteMagnitude
        var minY = Double.greatestFiniteMagnitude, maxY = -Double.greatestFiniteMagnitude
        
        for v in vertices {
            let dx = Double(v.x) - meanX, dz = Double(v.z) - meanZ
            let s = dx * major.x + dz * major.y
            let t = dx * minor.x + dz * minor.y
            minS = min(minS, s); maxS = max(maxS, s)
            minT = min(minT, t); maxT = max(maxT, t)
            minY = min(minY, Double(v.y)); maxY = max(maxY, Double(v.y))
        }
        
        let lengthCM = abs(maxS - minS) * 100.0
        let widthCM = abs(maxT - minT) * 100.0
        
        var archCM: Double? = nil
        if let groundY = groundY {
            let archHeight = Float(maxY) - groundY
            if archHeight > 0 { archCM = Double(archHeight * 100.0) }
        }
        
        guard lengthCM > 15 && lengthCM < 45 else { return nil }
        guard widthCM > 5 && widthCM < 15 else { return nil }
        
        return FootMeasurements(
            lengthCM: lengthCM,
            widthCM: widthCM,
            archHeightCM: archCM,
            timeStamp: Date(),
            meshCount: meshCount,
            footSide: footSide
        )
    }
}
