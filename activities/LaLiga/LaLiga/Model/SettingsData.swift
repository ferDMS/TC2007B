//
//  SettingsData.swift
//  LaLiga
//
//  Created by PEZ on 11/10/24.
//

import Foundation

class SettingsData: ObservableObject {
    @Published var bgColor: BackgroundColor
    @Published var fontColor: FontColor
    
    // Loads settings from the saved UserPrefs
    init() {
        // In case no settings are loaded, load default ones into UserPrefs
        loadDefaultSettings()
        
        // Once we are 100% sure that there are settings in UserPrefs, load them into this structure
        bgColor = loadBackgroundColor()
        print("Loaded initial background color")
        fontColor = loadFontColor()
        print("Loaded initial font color")
    }
    
    func saveBackgroundSetting(_ bgColorIn: BackgroundColor) {
        bgColor = bgColorIn
        saveBackgroundColor(bgColorIn)
    }
    
    func saveFontSetting(_ fontColorIn: FontColor) {
        fontColor = fontColorIn
        saveFontColor(fontColorIn)
    }
}
