import SwiftUI

// MARK: - FIFA 2026 Color Theme
extension Color {
    // Primary colors from FIFA website
    static let fifaNavy = Color(red: 0.067, green: 0.106, blue: 0.149)
    static let fifaDarkBlue = Color(red: 0.082, green: 0.133, blue: 0.184)
    static let fifaBlue = Color(red: 0.106, green: 0.165, blue: 0.224)
    static let fifaAccentBlue = Color(red: 0.2, green: 0.447, blue: 0.737)
    static let fifaLightBlue = Color(red: 0.412, green: 0.698, blue: 0.890)
    
    static let fifaWhite = Color.white
    static let fifaGray = Color(red: 0.6, green: 0.6, blue: 0.6)
    static let fifaLightGray = Color(red: 0.85, green: 0.85, blue: 0.85)
    
    static let fifaGold = Color(red: 0.835, green: 0.682, blue: 0.357)
    static let fifaGreen = Color(red: 0.235, green: 0.675, blue: 0.231)
}

class UserSettings: ObservableObject {
    @Published var sizeFormat: SizeFormat = .us
    @Published var sizeGender: SizeGender = .mens
    @Published var username: String = ""
    @Published var isLoggedIn: Bool = false
}

struct ContentView: View {
    @StateObject private var settings = UserSettings()
    @State private var showScan = false
    @State private var showSettings = false
    @State private var showLoginSheet = false
    @State private var showFootSelection = false
    
    var body: some View {
        ZStack {
            Color.fifaNavy
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    //Logo area
                    HStack(spacing: 8) {
                        Image(systemName: "soccerball.inverse")
                            .font(.title2)
                            .foregroundColor(.fifaWhite)
                        Text("YOU FEET")
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .tracking(2)
                            .foregroundColor(.fifaWhite)
                    }
                    
                    Spacer()
                    
                    // User status
                    if settings.isLoggedIn {
                        HStack(spacing: 6) {
                            Circle()
                                .fill(Color.fifaGreen)
                                .frame(width: 8, height: 8)
                            Text(settings.username)
                                .font(.subheadline)
                                .foregroundColor(.fifaWhite)
                        }
                    } else {
                        Button(action: { showLoginSheet = true }) {
                            HStack(spacing: 6) {
                                Image(systemName: "person.circle")
                                Text("Sign In")
                                    .font(.subheadline)
                            }
                            .foregroundColor(.fifaLightGray)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color.fifaDarkBlue)
                
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            // Logo
                            ZStack {
                                Circle()
                                    .fill(Color.fifaBlue)
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: "soccerball")
                                    .font(.system(size: 45))
                                    .foregroundColor(.fifaWhite)
                            }
                            
                            VStack(spacing: 6) {
                                Text("3D Foot Measurement")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.fifaWhite)
                                
                                Text("Powered by LiDAR Technology")
                                    .font(.caption)
                                    .foregroundColor(.fifaGray)
                            }
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                        
                        //Scan Button
                        Button(action: {
                            showFootSelection = true
                        }) {
                            HStack(spacing: 14) {
                                ZStack {
                                    Circle()
                                        .fill(Color.fifaWhite.opacity(0.15))
                                        .frame(width: 44, height: 44)
                                    
                                    Image(systemName: "viewfinder")
                                        .font(.title2)
                                        .foregroundColor(.fifaWhite)
                                }
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Start New Scan")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.fifaWhite)
                                    
                                    Text("Scan your foot for size recommendation")
                                        .font(.caption)
                                        .foregroundColor(.fifaLightGray)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.fifaGray)
                            }
                            .padding(20)
                            .background(Color.fifaAccentBlue)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            // History
                            QuickActionCard(
                                icon: "clock.arrow.circlepath",
                                title: "Scan History",
                                subtitle: "View past scans"
                            ) {
                                print("History tapped")
                            }
                            
                            // Settings
                            QuickActionCard(
                                icon: "gearshape",
                                title: "Settings",
                                subtitle: "Size preferences"
                            ) {
                                showSettings = true
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        //Shoe Recommendations
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "shoeprints.fill")
                                    .foregroundColor(.fifaAccentBlue)
                                Text("Shoe Recommendations")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.fifaWhite)
                                
                                Spacer()
                                
                                Text("Coming Soon")
                                    .font(.caption2)
                                    .fontWeight(.medium)
                                    .foregroundColor(.fifaNavy)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.fifaLightBlue)
                                    .cornerRadius(4)
                            }
                            
                            Text("After scanning, get personalized shoe recommendations based on your foot shape and size.")
                                .font(.caption)
                                .foregroundColor(.fifaGray)
                                .lineSpacing(4)
                        }
                        .padding(16)
                        .background(Color.fifaBlue)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.05), lineWidth: 1)
                        )
                        .padding(.horizontal, 20)
                        
                        // Current Size Settings Display
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Current Size Settings")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.fifaGray)
                            
                            HStack(spacing: 16) {
                                SettingPill(
                                    icon: "ruler",
                                    text: settings.sizeFormat.displayName
                                )
                                
                                SettingPill(
                                    icon: "person.fill",
                                    text: settings.sizeGender.displayName
                                )
                                
                                Spacer()
                                
                                Button(action: { showSettings = true }) {
                                    Text("Change")
                                        .font(.caption)
                                        .foregroundColor(.fifaAccentBlue)
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.fifaBlue)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Adidas Partner Badge
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.fifaGold)
                            
                            Text("Size recommendations powered by official Adidas sizing data")
                                .font(.caption2)
                                .foregroundColor(.fifaGray)
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        .sheet(isPresented: $showFootSelection) {
            FootSelectionView(settings: settings)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(settings: settings)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showLoginSheet) {
            LoginView(settings: settings, showLoginSheet: $showLoginSheet)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}


struct QuickActionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.fifaAccentBlue)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.fifaWhite)
                    
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundColor(.fifaGray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color.fifaBlue)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
        }
    }
}

struct SettingPill: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
        }
        .foregroundColor(.fifaWhite)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.fifaDarkBlue)
        .cornerRadius(16)
    }
}

struct FootSelectionView: View {
    @ObservedObject var settings: UserSettings
    @Environment(\.dismiss) var dismiss
    @State private var selectedFoot: FootSide = .left
    @State private var showScan = false
    
    var body: some View {
        ZStack {
            Color.fifaNavy.ignoresSafeArea()
            
            VStack(spacing: 24) {

                VStack(spacing: 8) {
                    Image(systemName: "foot.2")
                        .font(.system(size: 40))
                        .foregroundColor(.fifaAccentBlue)
                    
                    Text("Which foot are you scanning?")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.fifaWhite)
                    
                    Text("Select the foot you want to measure")
                        .font(.caption)
                        .foregroundColor(.fifaGray)
                }
                .padding(.top, 20)
                
            
                HStack(spacing: 16) {
                    FootOptionButton(
                        side: .left,
                        isSelected: selectedFoot == .left
                    ) {
                        selectedFoot = .left
                    }
                    
                    FootOptionButton(
                        side: .right,
                        isSelected: selectedFoot == .right
                    ) {
                        selectedFoot = .right
                    }
                }
                .padding(.horizontal, 24)
                
                Button(action: {
                    showScan = true
                }) {
                    Text("Continue to Scan")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.fifaNavy)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.fifaWhite)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showScan) {
            ScanView(settings: settings, selectedFoot: selectedFoot)
        }
    }
}

struct FootOptionButton: View {
    let side: FootSide
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(isSelected ? Color.fifaAccentBlue : Color.fifaBlue)
                        .frame(width: 70, height: 70)
                    
                    Image(systemName: side == .left ? "arrow.left" : "arrow.right")
                        .font(.title)
                        .foregroundColor(.fifaWhite)
                }
                
                Text(side.displayName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .fifaWhite : .fifaGray)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(isSelected ? Color.fifaDarkBlue : Color.fifaBlue)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.fifaAccentBlue : Color.clear, lineWidth: 2)
            )
        }
    }
}

struct SettingsView: View {
    @ObservedObject var settings: UserSettings
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.fifaNavy.ignoresSafeArea()
            
            VStack(spacing: 0) {

                HStack {
                    Text("Settings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.fifaWhite)
                    
                    Spacer()
                    
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.fifaGray)
                    }
                }
                .padding(20)
                
                ScrollView {
                    VStack(spacing: 24) {

                        VStack(alignment: .leading, spacing: 12) {
                            Text("SIZE FORMAT")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.fifaGray)
                                .tracking(1)
                            
                            VStack(spacing: 8) {
                                ForEach(SizeFormat.allCases, id: \.self) { format in
                                    SettingsOptionRow(
                                        title: format.displayName,
                                        isSelected: settings.sizeFormat == format
                                    ) {
                                        settings.sizeFormat = format
                                    }
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("SIZE CHART")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.fifaGray)
                                .tracking(1)
                            
                            VStack(spacing: 8) {
                                ForEach(SizeGender.allCases, id: \.self) { gender in
                                    SettingsOptionRow(
                                        title: gender.displayName,
                                        isSelected: settings.sizeGender == gender
                                    ) {
                                        settings.sizeGender = gender
                                    }
                                }
                            }
                        }
                        
                        HStack(spacing: 10) {
                            Image(systemName: "info.circle")
                                .foregroundColor(.fifaAccentBlue)
                            
                            Text("Size recommendations use official Adidas sizing charts.")
                                .font(.caption)
                                .foregroundColor(.fifaGray)
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
}

struct SettingsOptionRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundColor(.fifaWhite)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.fifaAccentBlue)
                } else {
                    Circle()
                        .stroke(Color.fifaGray, lineWidth: 1.5)
                        .frame(width: 22, height: 22)
                }
            }
            .padding(16)
            .background(Color.fifaBlue)
            .cornerRadius(10)
        }
    }
}

struct LoginView: View {
    @ObservedObject var settings: UserSettings
    @Binding var showLoginSheet: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    var body: some View {
        ZStack {
            Color.fifaNavy.ignoresSafeArea()
            
            VStack(spacing: 24) {

                VStack(spacing: 8) {
                    Image(systemName: "soccerball")
                        .font(.system(size: 40))
                        .foregroundColor(.fifaAccentBlue)
                    
                    Text("Sign In")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.fifaWhite)
                    
                    Text("Access your YouFeet account")
                        .font(.caption)
                        .foregroundColor(.fifaGray)
                }
                .padding(.top, 20)
                
                VStack(spacing: 16) {

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Username")
                            .font(.caption)
                            .foregroundColor(.fifaGray)
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.fifaAccentBlue)
                            TextField("", text: $username)
                                .foregroundColor(.fifaWhite)
                                .autocapitalization(.none)
                        }
                        .padding()
                        .background(Color.fifaBlue)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        )
                    }
                    
                    // Password
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.caption)
                            .foregroundColor(.fifaGray)
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.fifaAccentBlue)
                            
                            if isPasswordVisible {
                                TextField("", text: $password)
                                    .foregroundColor(.fifaWhite)
                            } else {
                                SecureField("", text: $password)
                                    .foregroundColor(.fifaWhite)
                            }
                            
                            Button(action: { isPasswordVisible.toggle() }) {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.fifaGray)
                            }
                        }
                        .padding()
                        .background(Color.fifaBlue)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        )
                    }
                }
                .padding(.horizontal, 24)
                
                // Sign In Button
                Button(action: {
                    if !username.isEmpty {
                        settings.username = username
                        settings.isLoggedIn = true
                        showLoginSheet = false
                    }
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.fifaNavy)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(username.isEmpty ? Color.fifaGray : Color.fifaWhite)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                .disabled(username.isEmpty)
                
                Text("Demo: Enter any username to continue")
                    .font(.caption2)
                    .foregroundColor(.fifaGray)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
