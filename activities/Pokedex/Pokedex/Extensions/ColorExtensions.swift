//
//  ColorExtensions.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
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

// Dictionary mapping each type to its darkened color
let pokemonTypeColors: [String: Color] = [
    "normal": Color(hex: "#A8A878").opacity(0.8),
    "fire": Color(hex: "#F08030").opacity(0.8),
    "water": Color(hex: "#6890F0").opacity(0.8),
    "grass": Color(hex: "#78C850").opacity(0.8),
    "electric": Color(hex: "#F8D030").opacity(0.8),
    "ice": Color(hex: "#98D8D8").opacity(0.8),
    "fighting": Color(hex: "#C03028").opacity(0.8),
    "poison": Color(hex: "#A040A0").opacity(0.8),
    "ground": Color(hex: "#E0C068").opacity(0.8),
    "flying": Color(hex: "#A890F0").opacity(0.8),
    "psychic": Color(hex: "#F85888").opacity(0.8),
    "bug": Color(hex: "#A8B820").opacity(0.8),
    "rock": Color(hex: "#B8A038").opacity(0.8),
    "ghost": Color(hex: "#705898").opacity(0.8),
    "dragon": Color(hex: "#7038F8").opacity(0.8),
    "dark": Color(hex: "#705848").opacity(0.8),
    "steel": Color(hex: "#B8B8D0").opacity(0.8),
    "fairy": Color(hex: "#F0B6BC").opacity(0.8),
    "stellar": Color(hex: "#35ACE7").opacity(0.8),
    "unknown": Color(hex: "#6AA596").opacity(0.8)
]

// Save color palette
extension Color {
    static let pokeYellow = Color(red: 255/255, green: 204/255, blue: 0/255) // Bright yellow
    static let pokeBlue = Color(red: 61/255, green: 125/255, blue: 202/255) // Soft blue
    static let pokeDarkBlue = Color(red: 0/255, green: 49/255, blue: 83/255) // Dark blue
    static let pokeWhite = Color(red: 255/255, green: 255/255, blue: 255/255) // Pure white
    static let pokeLightGray = Color(red: 235/255, green: 235/255, blue: 235/255) // Light gray
    static let pokeGray = Color(red: 169/255, green: 169/255, blue: 169/255) // Medium gray
    static let pokeRed = Color(red: 255/255, green: 0/255, blue: 0/255) // Bright red (for accents)
}
