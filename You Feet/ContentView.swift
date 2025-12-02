//
//  ContentView.swift
//  You Feet
//
//  Created by Moises Lacouture on 30/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScan = false
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [Color(red: 0.3, green: 0.2, blue: 0.6), Color(red: 0.2, green: 0.1, blue: 0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack(spacing: 15) {
                    Image(systemName: "figure.walk")
                        .foregroundStyle(.white)
                        .font(.system(size: 70))
                    Text("YouFeet")
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("By Moises Lacouture")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                    Text("3D Foot Measurement")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                Spacer()
                VStack(spacing: 15){
                    Button(action: {
                        print("Scan Tapped")
                        showScan = true
                    }, label: {
                        Label("Scan", systemImage: "camera.fill")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.4, green: 0.3, blue: 0.7))
                            .cornerRadius(40)
                    })
                    Button(action: {
                        print("Previous Scans Tapped")
                    }, label: {
                        Label("Previous Scans", systemImage: "shoeprints.fill")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.4, green: 0.3, blue: 0.7))
                            .cornerRadius(40)
                    })
                    Button(action: {
                        print("Settings Tapped")
                    }, label: {
                        Label("Settings", systemImage: "gear")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.4, green: 0.3, blue: 0.7))
                            .cornerRadius(40)
                    })
                    
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $showScan,){
            ScanView()
        }
    }
}

#Preview {
    ContentView()
}
