

import SwiftUI

struct ScanView: View {
    @StateObject private var viewModel = ScanViewModel()
    
    var body: some View {
        ZStack{
            
            LidarARView(viewModel: viewModel)
                .ignoresSafeArea()
            
            VStack{
                VStack(spacing: 10){
                    Text(viewModel.message)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    if viewModel.groundPlane {
                        Label("Ground Detected", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.caption)
                    }
                    
                    if viewModel.meshCount > 0 {
                        Text("\(viewModel.meshCount) meshes")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .padding(.top, 60)
                
                Spacer()
                Text("Swipe down to close")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .padding()
                    .cornerRadius(8)
                    .padding(.bottom, 30)
            }
        }
        .onAppear {
            viewModel.scanStarted()
        }
    }
}

#Preview {
    ScanView()
}
