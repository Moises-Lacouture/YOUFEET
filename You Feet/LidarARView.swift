import SwiftUI
import RealityKit
import ARKit
import simd

struct LidarARView: UIViewRepresentable {
    @ObservedObject var viewModel: ScanViewModel
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let configuration = ARWorldTrackingConfiguration()
        
        // Enable mesh reconstruction if available
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            configuration.sceneReconstruction = .mesh
            print("Lidar mesh reconstruction enabled")
        } else {
            print("Scene reconstruction not supported on this device")
        }
        
        // Detect horizontal planes (floor)
        configuration.planeDetection = [.horizontal]
        
        // Optional: use scene depth if available
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.sceneDepth) {
            configuration.frameSemantics.insert(.sceneDepth)
        }
        
        arView.session.delegate = context.coordinator
        arView.session.run(configuration)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Nothing to update dynamically for now
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var viewModel: ScanViewModel
        
        init(viewModel: ScanViewModel) {
            self.viewModel = viewModel
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            handleAnchors(anchors)
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            handleAnchors(anchors)
        }
        
        private func handleAnchors(_ anchors: [ARAnchor]) {
            for anchor in anchors {
                if let meshAnchor = anchor as? ARMeshAnchor {
                    processMeshAnchor(meshAnchor)
                } else if let planeAnchor = anchor as? ARPlaneAnchor {
                    // Horizontal plane = likely floor
                    if planeAnchor.alignment == .horizontal {
                        DispatchQueue.main.async {
                            self.viewModel.foundGroundPlane(at: planeAnchor.transform)
                        }
                    }
                }
            }
        }
        
        private func processMeshAnchor(_ meshAnchor: ARMeshAnchor) {
            let geometry = meshAnchor.geometry
            let vertices = geometry.vertices
            
            var worldVertices: [SIMD3<Float>] = []
            worldVertices.reserveCapacity(vertices.count)
            
            let vertexBuffer = vertices.buffer.contents()
            
            // Convert each vertex from local (anchor) space to world space
            for i in 0..<vertices.count {
                let offset = i * vertices.stride
                let localVertex = vertexBuffer
                    .advanced(by: offset)
                    .assumingMemoryBound(to: SIMD3<Float>.self)
                    .pointee
                
                let worldPos4 = meshAnchor.transform * SIMD4<Float>(localVertex, 1.0)
                let worldPos = SIMD3<Float>(worldPos4.x, worldPos4.y, worldPos4.z)
                
                worldVertices.append(worldPos)
            }
            
            DispatchQueue.main.async {
                self.viewModel.addMesh(vertices: worldVertices)
            }
        }
    }
}
