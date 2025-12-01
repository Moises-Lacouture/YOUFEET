//
//  ContentView.swift
//  You Feet
//
//  Created by Moises Lacouture on 30/11/25.
//

import SwiftUI

struct ContentView: View {
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
                    Text("Final Project")
                        .font(.subheadline)
                }
                Spacer()
                VStack(){
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
