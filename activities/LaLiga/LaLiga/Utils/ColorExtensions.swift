//
//  ColorExtensions.swift
//  LaLiga
//
//  Created by PEZ
//
import SwiftUI

extension Color {
    // Initialize Color with a hex code
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

// Save color palette
extension Color {
    // For background
    static let brownLight = Color(red: 236/255, green: 223/255, blue: 204/255)
    static let brownNormal = Color(red: 220/255, green: 197/255, blue: 162/255)
    static let brownDark = Color(red: 243/255, green: 236/255, blue: 224/255)
    
    static let blueLight = Color(red: 204/255, green: 223/255, blue: 236/255)
    static let blueNormal = Color(red: 162/255, green: 197/255, blue: 220/255)
    static let blueDark = Color(red: 224/255, green: 236/255, blue: 243/255)
    
    static let redLight = Color(red: 236/255, green: 204/255, blue: 204/255)
    static let redNormal = Color(red: 220/255, green: 162/255, blue: 162/255)
    static let redDark = Color(red: 243/255, green: 224/255, blue: 224/255)
    
    // For text
    static let darkGreen = Color(red: 0/255, green: 100/255, blue: 0/255)
    static let darkBlue = Color(red: 0/255, green: 0/255, blue: 139/255)
}

enum BackgroundColor: String, CaseIterable {
    case brown, blue, red
    
    var colors: [Color] {
        switch self {
        case .brown:
            return [.brownLight, .brownNormal, .brownDark]
        case .blue:
            return [.blueLight, .blueNormal, .blueDark]
        case .red:
            return [.redLight, .redNormal, .redDark]
        }
    }
}

enum FontColor: String, CaseIterable {
    case black, green, blue
    
    var color: Color {
        switch self {
        case .black:
            return .black
        case .green:
            return .darkGreen
        case .blue:
            return .darkBlue
        }
    }
}
