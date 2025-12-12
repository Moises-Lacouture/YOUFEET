import Foundation
import SwiftUI

struct ResultsView: View {
    let measurements: FootMeasurements
    @ObservedObject var settings: UserSettings
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            // Dark navy background
            Color.fifaNavy
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Success Header
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.fifaGreen.opacity(0.2))
                                .frame(width: 90, height: 90)
                            
                            Circle()
                                .fill(Color.fifaGreen)
                                .frame(width: 70, height: 70)
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 35, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Text("Scan Complete!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.fifaWhite)
                        
                        // Foot indicator
                        HStack(spacing: 6) {
                            Image(systemName: measurements.footSide.icon)
                                .font(.caption)
                            Text(measurements.footSide.displayName)
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.fifaLightBlue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.fifaBlue)
                        .cornerRadius(20)
                    }
                    .padding(.top, 40)
                    
                    // Shoe Size Recommendation Card
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("RECOMMENDED SIZE")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.fifaGray)
                                    .tracking(1)
                                
                                Text(measurements.getFormattedAdidasSize(
                                    format: settings.sizeFormat,
                                    gender: settings.sizeGender
                                ))
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.fifaWhite)
                            }
                            
                            Spacer()
                            
                            ZStack {
                                Circle()
                                    .fill(Color.fifaAccentBlue.opacity(0.2))
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: "soccerball")
                                    .font(.title)
                                    .foregroundColor(.fifaAccentBlue)
                            }
                        }
                        
                        Divider()
                            .background(Color.white.opacity(0.1))
                        
                        // Size format info
                        HStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Format")
                                    .font(.caption2)
                                    .foregroundColor(.fifaGray)
                                Text(settings.sizeFormat.displayName)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.fifaWhite)
                            }
                            
                            Divider()
                                .frame(height: 30)
                                .background(Color.white.opacity(0.1))
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Chart")
                                    .font(.caption2)
                                    .foregroundColor(.fifaGray)
                                Text(settings.sizeGender.displayName)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.fifaWhite)
                            }
                            
                            Spacer()
                        }
                        
                        // Adidas badge
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.fifaGold)
                            Text("Based on official Adidas sizing")
                                .font(.caption)
                                .foregroundColor(.fifaGray)
                        }
                    }
                    .padding(20)
                    .background(Color.fifaBlue)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.fifaAccentBlue.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    
                    // All Sizes Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("ALL SIZE FORMATS")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.fifaGray)
                            .tracking(1)
                        
                        // Size grid
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            SizeDisplayCard(
                                format: "US Men's",
                                size: measurements.getAdidasSize(format: .us, gender: .mens)
                            )
                            SizeDisplayCard(
                                format: "US Women's",
                                size: measurements.getAdidasSize(format: .us, gender: .womens)
                            )
                            SizeDisplayCard(
                                format: "UK",
                                size: measurements.getAdidasSize(format: .uk, gender: settings.sizeGender)
                            )
                            SizeDisplayCard(
                                format: "EU",
                                size: measurements.getAdidasSize(format: .eu, gender: settings.sizeGender)
                            )
                            SizeDisplayCard(
                                format: "JP (cm)",
                                size: measurements.getAdidasSize(format: .jp, gender: settings.sizeGender)
                            )
                        }
                    }
                    .padding(20)
                    .background(Color.fifaBlue)
                    .cornerRadius(16)
                    .padding(.horizontal, 20)
                    
                    // Measurements Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("MEASUREMENTS")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.fifaGray)
                            .tracking(1)
                        
                        VStack(spacing: 0) {
                            MeasurementRow(
                                icon: "ruler",
                                label: "Foot Length",
                                value: measurements.formattedLength,
                                iconColor: .fifaAccentBlue
                            )
                            
                            Divider()
                                .background(Color.white.opacity(0.1))
                            
                            MeasurementRow(
                                icon: "arrow.left.and.right",
                                label: "Foot Width",
                                value: measurements.formattedWidth,
                                iconColor: .fifaAccentBlue
                            )
                            
                            if measurements.archHeightCM != nil {
                                Divider()
                                    .background(Color.white.opacity(0.1))
                                
                                MeasurementRow(
                                    icon: "arrow.up",
                                    label: "Arch Height",
                                    value: measurements.formattedArchHeight,
                                    iconColor: .fifaAccentBlue
                                )
                            }
                        }
                    }
                    .padding(20)
                    .background(Color.fifaBlue)
                    .cornerRadius(16)
                    .padding(.horizontal, 20)
                    
                    // Scan Info
                    HStack(spacing: 8) {
                        Image(systemName: "cube.transparent")
                            .foregroundColor(.fifaGray)
                        Text("Based on \(measurements.meshCount) 3D mesh scans")
                            .font(.caption)
                            .foregroundColor(.fifaGray)
                    }
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        // Save to Profile (Future Feature)
                        Button(action: {
                            print("Save to Profile Tapped")
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                Text("Save to Profile")
                            }
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.fifaWhite)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.fifaDarkBlue)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                            )
                        }
                        
                        // Done Button
                        Button(action: onDismiss) {
                            Text("Done")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.fifaNavy)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.fifaWhite)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

// MARK: - Size Display Card
struct SizeDisplayCard: View {
    let format: String
    let size: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(format)
                .font(.caption2)
                .foregroundColor(.fifaGray)
            
            Text(size)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.fifaWhite)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color.fifaDarkBlue)
        .cornerRadius(10)
    }
}

// MARK: - Measurement Row
struct MeasurementRow: View {
    let icon: String
    let label: String
    let value: String
    var iconColor: Color = .fifaAccentBlue
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(iconColor)
                .frame(width: 30)
            
            Text(label)
                .font(.subheadline)
                .foregroundColor(.fifaGray)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.fifaWhite)
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    ResultsView(
        measurements: FootMeasurements(
            lengthCM: 26.5,
            widthCM: 10.2,
            archHeightCM: 4.5,
            timeStamp: Date(),
            meshCount: 15,
            footSide: .left
        ),
        settings: UserSettings(),
        onDismiss: {}
    )
}
