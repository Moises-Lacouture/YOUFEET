YouFeet - 3D Foot Measurement App

*Logo

YouFeet is an iOS application that uses LiDAR(photogrammetry in the future too) technology to scan and measure feet in 3D, providing accurate shoe size recommendations based on official Adidas sizing data.

App Overview

YouFeet leverages the iPhone's LiDAR sensor to capture precise 3D measurements of your foot, then converts those measurements into shoe size recommendations across multiple international sizing standards (US, UK, EU, JP).

Key Features

- **LiDAR 3D Scanning** - Uses ARKit and scene reconstruction to capture accurate foot geometry
- **Multi-Format Size Recommendations** - Get your size in US (Men's/Women's), UK, EU, and JP formats
- **Official Adidas Sizing** - Size calculations based on official Adidas 2025 size charts
- **Left/Right Foot Selection** - Scan either foot with dedicated tracking
- **FIFA-Inspired** - Purpose to be used for one of Fifa's main sponsors, Adidas.
- **User Preferences** - Save your preferred size format and gender for quick access

Target Audience

- Football/soccer players looking for properly fitted boots
- Runners needing accurate foot measurements for buying appropiate shoes
- Anyone shopping for shoes online who needs sizing

Setup Instructions

Requirements:

- **Device**: iPhone 12 Pro or later (requires LiDAR sensor, Pro models only, future feature is to use photogammetry so other phones ca use the app too.)
- **iOS**: iOS 15.0+
- 
The app requires the following permissions:
- **Camera** - Required for AR scanning functionality

## 🎬 Demo Video

[**Watch the Demo Video**](YOUR_DEMO_LINK_HERE)

## Screenshots

| Home Screen | Foot Selection | Scanning |
![Main Page](Photos/Main_page.PNG)
| Results | Settings | Login |

| ![Results](Screenshots/results.png) | ![Settings](Screenshots/settings.png) | ![Login](Screenshots/login.png) |

Project Structure:

You_FeetApp.swift -- App entry point
ContentView.swift -- Main home screen with navigation
ScanView.swift -- AR scanning interface
ScanViewModel.swift -- Scanning logic and mesh processing
LidarARView.swift -- ARKit/RealityKit integration
ResultsView.swift -- Measurement results display
FootMeasurements.swift -- Data models and Adidas size chart


How It Works:

1. **Floor Detection** - The app first detects the ground plane using ARKit's plane detection
2. **Mesh Capture** - LiDAR captures 3D mesh data of the foot
4. **Filtering** - Intelligent filtering removes floor and background geometry
5. **Vertices calculations** - Gets the distance from each vertice to get the size of the feet thanks to the mesh
6. **PCA Analysis** - Principal Component Analysis determines foot orientation for accurate length/width measurement
7. **Size Calculation** - Measurements are matched against Adidas size charts

By:
**Moises Lacouture**

iPhone App Development 2 - Fall 2025

*Size chart ownership: Adidas.
*This app is for educational purposes only.
