//
//  SettingsView.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var modelData: ModelData
    @State public var selectedBgColor: BackgroundColor
    @State public var selectedFontColor: FontColor
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Section(header: Text("Background Color")) {
                Picker("Background Color", selection: $selectedBgColor) {
                    ForEach(BackgroundColor.allCases, id: \.self) { color in
                        Text(color.rawValue.capitalized).tag(color)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Font Color")) {
                Picker("Font Color", selection: $selectedFontColor) {
                    ForEach(FontColor.allCases, id: \.self) { color in
                        Text(color.rawValue.capitalized).tag(color)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Spacer()
        }
        .padding(20)
        .onAppear {
            let (bgColor, fontColor) = loadUserSettings()
            self.selectedBgColor = bgColor
            self.selectedFontColor = fontColor
        }
        .onChange(of: selectedBgColor) {
            saveUserSettings(bgColor: selectedBgColor, fontColor: selectedFontColor)
        }
        .onChange(of: selectedFontColor) {
            saveUserSettings(bgColor: selectedBgColor, fontColor: selectedFontColor)
        }
    }
}

#Preview {
    SettingsView(selectedBgColor: BackgroundColor.red, selectedFontColor: FontColor.blue)
        .environmentObject(ModelData())
}
