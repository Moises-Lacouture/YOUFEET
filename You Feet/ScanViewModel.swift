
import SwiftUI
import ARKit

class ScanViewModel: ObservableObject {
    @Published var meshCount = 0;
    @Published var groundPlane = false;
    @Published var scanning = false;
    @Published var message = "Point Camera at the floor";
    
    func addMesh() {
        meshCount += 1;
        
        print("Mesh added, total count: \(meshCount)")
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
        groundPlane = false;
        scanning = true;
        message = "Point Camera at the floor";
     
        print("Scanning started")
    }
    
    private func updateStat() {
            if !groundPlane {
                message = "Point camera at floor";
            } else if meshCount == 0 {
                message = "Ground detected! Scan your foot";
            } else {
                message = "\(meshCount) mesh segments captured";
            }
    }
}
