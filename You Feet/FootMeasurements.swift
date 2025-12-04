import Foundation

struct FootMeasurements: Identifiable{
    let id = UUID()
    let lengthCM: Double
    let widthCM: Double
    let archHeightCM: Double?
    let timeStamp: Date
    let meshCount: Int
    
    var lengthInches: Double {
        return lengthCM / 2.54
    }
    var widthInches: Double {
        return widthCM / 2.54
    }
    
    var formattedLength: String {
        String (format: "%1.f cm (%.1f\")", lengthCM, lengthInches)
    }
    var formattedWidth: String {
        String (format: "%1.f cm (%.1f\")", widthCM, widthInches)
    }
    
    var formattedArchHeight: String {
        if let archCm = archHeightCM{
            let archInches = archCm / 2.54
            return String(format: "%.1f cm (%1.f\")", archCm, archInches)
        }
        return "Not measured."
    }
    var estimatedShoeSize: String {
        let sizeChart: [(maxLength: Double, size: String)] = [
            (21.6, "4"),
            (22.2, "4.5"),
            (22.9, "5"),
            (23.5, "5.5"),
            (24.1, "6"),
            (24.8, "6.5"),
            (25.4, "7"),
            (26.0, "7.5"),
            (26.7, "8"),
            (27.3, "8.5"),
            (27.9, "9"),
            (28.6, "9.5"),
            (29.2, "10"),
            (29.8, "10.5"),
            (30.5, "11"),
            (31.1, "11.5"),
            (31.8, "12"),
            (32.4, "12.5"),
            (33.0, "13")
        ]
        
        for entry in sizeChart {
            if lengthCM <= entry.maxLength {
                return "US \(entry.size)"
            }
        }
        return "US 13+"
    }
}
