//
//  UserDefaultsUtils.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//

import Foundation

func setDefaultUserSettings() {
    let defaults = UserDefaults.standard
    
    if defaults.string(forKey: "bgColor") == nil {
        defaults.set("brown", forKey: "bgColor")
    }
    
    if defaults.string(forKey: "fontColor") == nil {
        defaults.set("black", forKey: "fontColor")
    }
}

func loadUserSettings() -> (BackgroundColor, FontColor) {
    let defaults = UserDefaults.standard
    
    let bgColorString = defaults.string(forKey: "bgColor") ?? "brown"
    let bgColor = BackgroundColor(rawValue: bgColorString) ?? .brown
    
    let fontColorString = defaults.string(forKey: "fontColor") ?? "black"
    let fontColor = FontColor(rawValue: fontColorString) ?? .black
    
    return (bgColor, fontColor)
}

func saveUserSettings(bgColor: BackgroundColor, fontColor: FontColor) {
    let defaults = UserDefaults.standard
    defaults.set(bgColor.rawValue, forKey: "bgColor")
    defaults.set(fontColor.rawValue, forKey: "fontColor")
}
