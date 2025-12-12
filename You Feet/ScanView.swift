import SwiftUI

struct ScanView: View {
    @ObservedObject var settings: UserSettings
    let selectedFoot: FootSide
    
    @StateObject private var viewModel = ScanViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            if !viewModel.showResults {
                ZStack {
                    // AR View
                    LidarARView(viewModel: viewModel)
                        .ignoresSafeArea()
                    
                    // Overlay UI
                    VStack {
                        // Status Bar
                        VStack(spacing: 10) {
                            // Foot indicator
                            HStack(spacing: 8) {
                                Image(systemName: selectedFoot.icon)
                                    .font(.caption)
                                Text(selectedFoot.displayName)
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.fifaLightBlue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.fifaNavy.opacity(0.8))
                            .cornerRadius(20)
                            
                            // Main message
                            HStack(spacing: 10) {
                                if viewModel.groundPlane {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.fifaGreen)
                                } else {
                                    Image(systemName: "viewfinder")
                                        .foregroundColor(.fifaLightBlue)
                                }
                                
                                Text(viewModel.message)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            
                            // Mesh counter
                            if viewModel.meshCount > 0 {
                                HStack(spacing: 6) {
                                    Image(systemName: "cube.transparent")
                                        .font(.caption)
                                    Text("\(viewModel.meshCount) mesh sections captured")
                                        .font(.caption)
                                }
                                .foregroundColor(.fifaLightGray)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .background(Color.fifaNavy.opacity(0.95))
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        )
                        .padding(.top, 60)
                        .padding(.horizontal, 20)
                        
                        Spacer()
                        
                        // Bottom Controls
                        VStack(spacing: 16) {
                            if viewModel.meshCount >= 5 {
                                // Calculate Button
                                Button(action: {
                                    viewModel.scanFinished(footSide: selectedFoot)
                                }) {
                                    HStack(spacing: 10) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.title3)
                                        Text("Calculate Measurements")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                    }
                                    .foregroundColor(.fifaNavy)
                                    .padding(.vertical, 16)
                                    .frame(maxWidth: 320)
                                    .background(Color.fifaWhite)
                                    .cornerRadius(14)
                                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                                }
                            } else {
                                // Scanning instruction
                                VStack(spacing: 8) {
                                    // Progress dots
                                    HStack(spacing: 6) {
                                        ForEach(0..<5) { index in
                                            Circle()
                                                .fill(index < viewModel.meshCount ? Color.fifaAccentBlue : Color.white.opacity(0.3))
                                                .frame(width: 8, height: 8)
                                        }
                                    }
                                    
                                    Text("Scan your \(selectedFoot.displayName.lowercased()) from multiple angles")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.9))
                                    
                                    if viewModel.meshCount > 0 {
                                        Text("\(5 - viewModel.meshCount) more scans needed")
                                            .font(.caption)
                                            .foregroundColor(.fifaLightBlue)
                                    }
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 16)
                                .background(Color.fifaNavy.opacity(0.95))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                )
                            }
                            
                            // Cancel Button
                            Button(action: {
                                dismiss()
                            }) {
                                Text("Cancel")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        .padding(.bottom, 80)
                    }
                    
                    // Scanning frame overlay
                    ScanFrameOverlay()
                }
            } else {
                // Results View
                if let measurements = viewModel.measurements {
                    ResultsView(
                        measurements: measurements,
                        settings: settings
                    ) {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            viewModel.scanStarted()
        }
    }
}

// MARK: - Scan Frame Overlay
struct ScanFrameOverlay: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width * 0.75
            let height = geometry.size.height * 0.45
            let centerX = geometry.size.width / 2
            let centerY = geometry.size.height / 2
            
            ZStack {
                // Corner brackets
                // Top Left
                CornerBracket()
                    .position(x: centerX - width/2 + 15, y: centerY - height/2 + 15)
                
                // Top Right
                CornerBracket()
                    .rotationEffect(.degrees(90))
                    .position(x: centerX + width/2 - 15, y: centerY - height/2 + 15)
                
                // Bottom Left
                CornerBracket()
                    .rotationEffect(.degrees(-90))
                    .position(x: centerX - width/2 + 15, y: centerY + height/2 - 15)
                
                // Bottom Right
                CornerBracket()
                    .rotationEffect(.degrees(180))
                    .position(x: centerX + width/2 - 15, y: centerY + height/2 - 15)
            }
        }
        .allowsHitTesting(false)
    }
}

struct CornerBracket: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 30))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 30, y: 0))
        }
        .stroke(Color.fifaWhite, lineWidth: 2)
        .frame(width: 30, height: 30)
    }
}

#Preview {
    ScanView(settings: UserSettings(), selectedFoot: .left)
}
