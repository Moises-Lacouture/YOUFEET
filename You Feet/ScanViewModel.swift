
import SwiftUI
import ARKit
import Foundation

class ScanViewModel: ObservableObject {
    @Published var meshCount = 0;
    @Published var groundPlane = false;
    @Published var scanning = false;
    @Published var message = "Point Camera at the floor";
    @Published var measurements: FootMeasurements?
    @Published var showResults: Bool = false
    
    private var collectedVertices: [SIMD3<Float>] = []
    
    func addMesh(vertices: [SIMD3<Float>]) {
        meshCount += 1;
        
        collectedVertices.append(contentsOf: vertices)
        print("Mesh added, total mesh count: \(meshCount), Vertices: \(collectedVertices.count)")
        updateStat()
    }
    
    func foundGroundPlane(){
        if !groundPlane {
            groundPlane = true;
            
            print("Ground plane detected");
                updateStat()
        }
    }
    
    func scanStarted(){
        meshCount = 0;
        scanning = true;
        groundPlane = false;
        showResults = false
        measurements = nil
        message = "Point Camera at the floor";

        collectedVertices.removeAll()
     
        print("Scanning started")
    }
    
    func scanFinished(){
        scanning = false
        print("Scan finished. Processing vertices: \(collectedVertices.count)")
        
        measurements = measurementsCalc(from: collectedVertices)
        
        if let measurements = measurements{
            print("Length: \(measurements.formattedLength)")
            print("Width: \(measurements.formattedWidth)")
            print("Estimated Size: \(measurements.estimatedShoeSize)")
            
            showResults = true
        }else{
            print("Failed to calculate measurements")
            message = "Not enought data. Try again."
        }
    }
    
    private func updateStat() {
            if !groundPlane {
                message = "Point camera at floor";
            } else if meshCount == 0 {
                message = "Ground detected! Scan your foot";
            } else if meshCount < 5 {
                message = "Scanning your foot, move slowly";
            }else {
                message = "\(meshCount) mesh sections captured, almost there";
            }
    }
    private func measurementsCalc(from vertices: [SIMD3<Float>]) -> FootMeasurements? {
        guard vertices.count > 100 else {
            print("Not enough vertices: \(vertices.count)")
            return nil
        }
        
        let filteredVertices = vertices.filter { $0.y > 0.02 }
        
        guard filteredVertices.count > 50 else {
            print("Not enough point after filtering: \(filteredVertices.count)")
            return nil
        }
        
        let minX = filteredVertices.map { $0.x }.min() ?? 0
        let maxX = filteredVertices.map { $0.x }.max() ?? 0
        let minZ = filteredVertices.map { $0.z }.min() ?? 0
        let maxZ = filteredVertices.map { $0.z }.max() ?? 0
        let maxY = filteredVertices.map { $0.y }.max() ?? 0
        
        let lengthMeters = abs(maxZ - minZ)
        let widthMeters = abs(maxX - minX)
        let archMeters = maxY
        
        let lengthCM = Double(lengthMeters * 100)
        let widthCM = Double(widthMeters * 100)
        let archCM = Double(archMeters * 100)
        
        print("Raw measurements:")
        print("Length: \(lengthMeters)m = \(lengthCM)cm")
        print("Width: \(widthMeters)m = \(widthCM)cm")
        print("Arch: \(archMeters)m = \(archCM)cm")
        
        guard lengthCM > 15 && lengthCM < 35 else {
            print("Length out of range: \(lengthCM)cm")
            return nil
        }
        
        guard widthCM > 6 && widthCM < 15 else {
            print("Width out of range: \(widthCM)cm")
            return nil
        }
        
        return FootMeasurements(
            lengthCM: lengthCM,
            widthCM: widthCM,
            archHeightCM: archCM,
            timeStamp: Date(),
            meshCount: meshCount
        )
    }
}
