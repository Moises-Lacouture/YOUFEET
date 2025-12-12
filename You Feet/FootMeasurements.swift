import Foundation

// MARK: - Size Format Preference
enum SizeFormat: String, CaseIterable, Codable {
    case us = "US"
    case uk = "UK"
    case eu = "EU"
    case jp = "JP"
    
    var displayName: String {
        switch self {
        case .us: return "US"
        case .uk: return "UK"
        case .eu: return "EU"
        case .jp: return "JP (cm)"
        }
    }
}

// MARK: - Gender Preference for Sizing
enum SizeGender: String, CaseIterable, Codable {
    case mens = "mens"
    case womens = "womens"
    
    var displayName: String {
        switch self {
        case .mens: return "Men's"
        case .womens: return "Women's"
        }
    }
}

// MARK: - Foot Side
enum FootSide: String, CaseIterable, Codable {
    case left = "left"
    case right = "right"
    
    var displayName: String {
        switch self {
        case .left: return "Left Foot"
        case .right: return "Right Foot"
        }
    }
    
    var icon: String {
        switch self {
        case .left: return "arrow.left"
        case .right: return "arrow.right"
        }
    }
}

// MARK: - Adidas Size Entry
struct AdidasSizeEntry {
    let heelToeCM: Double
    let usMen: String
    let usWomen: String
    let eu: String
    let uk: String
    let jp: String // JP is in mm (220 = 22.0cm)
    
    func size(for format: SizeFormat, gender: SizeGender) -> String {
        switch format {
        case .us:
            return gender == .mens ? usMen : usWomen
        case .uk:
            return uk
        case .eu:
            return eu
        case .jp:
            return jp
        }
    }
}

// MARK: - Adidas Size Chart (Official 2025)
struct AdidasSizeChart {
    // Official Adidas size chart data from adidas.com
    static let sizes: [AdidasSizeEntry] = [
        AdidasSizeEntry(heelToeCM: 22.1, usMen: "4", usWomen: "5", eu: "36", uk: "3.5", jp: "220"),
        AdidasSizeEntry(heelToeCM: 22.5, usMen: "4.5", usWomen: "5.5", eu: "36⅔", uk: "4", jp: "225"),
        AdidasSizeEntry(heelToeCM: 22.9, usMen: "5", usWomen: "6", eu: "37⅓", uk: "4.5", jp: "230"),
        AdidasSizeEntry(heelToeCM: 23.3, usMen: "5.5", usWomen: "6.5", eu: "38", uk: "5", jp: "235"),
        AdidasSizeEntry(heelToeCM: 23.8, usMen: "6", usWomen: "7", eu: "38⅔", uk: "5.5", jp: "240"),
        AdidasSizeEntry(heelToeCM: 24.2, usMen: "6.5", usWomen: "7.5", eu: "39⅓", uk: "6", jp: "245"),
        AdidasSizeEntry(heelToeCM: 24.6, usMen: "7", usWomen: "8", eu: "40", uk: "6.5", jp: "250"),
        AdidasSizeEntry(heelToeCM: 25.0, usMen: "7.5", usWomen: "8.5", eu: "40⅔", uk: "7", jp: "255"),
        AdidasSizeEntry(heelToeCM: 25.5, usMen: "8", usWomen: "9", eu: "41⅓", uk: "7.5", jp: "260"),
        AdidasSizeEntry(heelToeCM: 25.9, usMen: "8.5", usWomen: "9.5", eu: "42", uk: "8", jp: "265"),
        AdidasSizeEntry(heelToeCM: 26.3, usMen: "9", usWomen: "10", eu: "42⅔", uk: "8.5", jp: "270"),
        AdidasSizeEntry(heelToeCM: 26.7, usMen: "9.5", usWomen: "10.5", eu: "43⅓", uk: "9", jp: "275"),
        AdidasSizeEntry(heelToeCM: 27.1, usMen: "10", usWomen: "11", eu: "44", uk: "9.5", jp: "280"),
        AdidasSizeEntry(heelToeCM: 27.6, usMen: "10.5", usWomen: "11.5", eu: "44⅔", uk: "10", jp: "285"),
        AdidasSizeEntry(heelToeCM: 28.0, usMen: "11", usWomen: "12", eu: "45⅓", uk: "10.5", jp: "290"),
        AdidasSizeEntry(heelToeCM: 28.4, usMen: "11.5", usWomen: "12.5", eu: "46", uk: "11", jp: "295"),
        AdidasSizeEntry(heelToeCM: 28.8, usMen: "12", usWomen: "13", eu: "46⅔", uk: "11.5", jp: "300"),
        AdidasSizeEntry(heelToeCM: 29.3, usMen: "12.5", usWomen: "13.5", eu: "47⅓", uk: "12", jp: "305"),
        AdidasSizeEntry(heelToeCM: 29.7, usMen: "13", usWomen: "14", eu: "48", uk: "12.5", jp: "310"),
        AdidasSizeEntry(heelToeCM: 30.1, usMen: "13.5", usWomen: "14.5", eu: "48⅔", uk: "13", jp: "315"),
        AdidasSizeEntry(heelToeCM: 30.5, usMen: "14", usWomen: "15", eu: "49⅓", uk: "13.5", jp: "320"),
        AdidasSizeEntry(heelToeCM: 31.0, usMen: "14.5", usWomen: "15.5", eu: "50", uk: "14", jp: "325"),
        AdidasSizeEntry(heelToeCM: 31.4, usMen: "15", usWomen: "--", eu: "50⅔", uk: "14.5", jp: "--"),
        AdidasSizeEntry(heelToeCM: 31.8, usMen: "16", usWomen: "--", eu: "51⅓", uk: "15", jp: "--"),
        AdidasSizeEntry(heelToeCM: 32.6, usMen: "17", usWomen: "--", eu: "52⅔", uk: "16", jp: "--"),
        AdidasSizeEntry(heelToeCM: 33.5, usMen: "18", usWomen: "--", eu: "53⅓", uk: "17", jp: "--"),
        AdidasSizeEntry(heelToeCM: 34.3, usMen: "19", usWomen: "--", eu: "54⅔", uk: "18", jp: "--"),
        AdidasSizeEntry(heelToeCM: 35.2, usMen: "20", usWomen: "--", eu: "55⅔", uk: "19", jp: "--")
    ]
    
    /// Find the best matching size for a given foot length in cm
    static func findSize(forLengthCM length: Double, format: SizeFormat, gender: SizeGender) -> String {
        // Find the size where heel-toe measurement is >= foot length
        // We add a small buffer (0.5cm) for comfort as recommended by Adidas
        let targetLength = length
        
        for entry in sizes {
            if entry.heelToeCM >= targetLength {
                let size = entry.size(for: format, gender: gender)
                if size == "--" {
                    // Size not available for this gender, find next available
                    continue
                }
                return size
            }
        }
        
        // If foot is larger than chart, return largest available
        if let lastEntry = sizes.last {
            let size = lastEntry.size(for: format, gender: gender)
            if size != "--" {
                return "\(size)+"
            }
        }
        
        return "Size not found"
    }
    
    /// Get the full size recommendation with format label
    static func getFormattedSize(forLengthCM length: Double, format: SizeFormat, gender: SizeGender) -> String {
        let size = findSize(forLengthCM: length, format: format, gender: gender)
        
        switch format {
        case .us:
            return "\(gender == .mens ? "US Men's" : "US Women's") \(size)"
        case .uk:
            return "UK \(size)"
        case .eu:
            return "EU \(size)"
        case .jp:
            return "JP \(size)"
        }
    }
}

// MARK: - Foot Measurements
struct FootMeasurements: Identifiable {
    let id = UUID()
    let lengthCM: Double
    let widthCM: Double
    let archHeightCM: Double?
    let timeStamp: Date
    let meshCount: Int
    let footSide: FootSide
    
    var lengthInches: Double {
        return lengthCM / 2.54
    }
    
    var widthInches: Double {
        return widthCM / 2.54
    }
    
    var formattedLength: String {
        String(format: "%.1f cm (%.1f\")", lengthCM, lengthInches)
    }
    
    var formattedWidth: String {
        String(format: "%.1f cm (%.1f\")", widthCM, widthInches)
    }
    
    var formattedArchHeight: String {
        if let archCm = archHeightCM {
            let archInches = archCm / 2.54
            return String(format: "%.1f cm (%.1f\")", archCm, archInches)
        }
        return "Not measured"
    }
    
    /// Get Adidas shoe size recommendation
    func getAdidasSize(format: SizeFormat, gender: SizeGender) -> String {
        return AdidasSizeChart.findSize(forLengthCM: lengthCM, format: format, gender: gender)
    }
    
    /// Get formatted Adidas shoe size with label
    func getFormattedAdidasSize(format: SizeFormat, gender: SizeGender) -> String {
        return AdidasSizeChart.getFormattedSize(forLengthCM: lengthCM, format: format, gender: gender)
    }
    
    /// Legacy US size (for backwards compatibility)
    var estimatedShoeSize: String {
        return getFormattedAdidasSize(format: .us, gender: .mens)
    }
}
