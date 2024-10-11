//
//  UserDefaultsUtils.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//

import Foundation

func loadDefaultSettings() {
    let defaults = UserDefaults.standard
    
    if defaults.string(forKey: "bgColor") == nil {
        defaults.set("brown", forKey: "bgColor")
    }
    
    if defaults.string(forKey: "fontColor") == nil {
        defaults.set("black", forKey: "fontColor")
    }
}

func loadBackgroundColor() -> BackgroundColor {
    let defaults = UserDefaults.standard
    let bgColorString = defaults.string(forKey: "bgColor")
    return BackgroundColor(rawValue: bgColorString ?? "brown")!
}

func loadFontColor() -> FontColor {
    let defaults = UserDefaults.standard
    let fontColorString = defaults.string(forKey: "fontColor")
    return FontColor(rawValue: fontColorString ?? "black")!
}

func saveBackgroundColor(_ bgColor: BackgroundColor?) {
    let defaults = UserDefaults.standard
    defaults.set(bgColor?.rawValue, forKey: "bgColor")
}

func saveFontColor(_ fontColor: FontColor?) {
    let defaults = UserDefaults.standard
    defaults.set(fontColor?.rawValue, forKey: "fontColor")
}
