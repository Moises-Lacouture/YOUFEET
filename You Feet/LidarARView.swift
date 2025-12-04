import SwiftUI
import RealityKit
import ARKit

struct LidarARView: UIViewRepresentable {
    @ObservedObject var viewModel: ScanViewModel
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let configuration = ARWorldTrackingConfiguration()
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            configuration.sceneReconstruction = .mesh
            print("Lidar mesh reconstruction enabled")
        } else {
            print("Lidar not available on this device")
        }
        
        configuration.planeDetection = [.horizontal]
        print("Plane detection active")
        
        arView.session.delegate = context.coordinator
        
        arView.session.run(configuration)
        print("AR started")
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
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
            for anchor in anchors {
                
                if let _ = anchor as? ARMeshAnchor {
 
                    DispatchQueue.main.async {//Mesh identified
                        self.viewModel.addMesh()
                        
                    }
                } else if let planeAnchor = anchor as? ARPlaneAnchor {
                    
                    if planeAnchor.alignment == .horizontal {//Floor identified
                        DispatchQueue.main.async {
                            self.viewModel.foundGroundPlane()
                            
                        }
                    }
                }
            }
        }
    }
}
