//
//  SettingsView.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var settingsData: SettingsData
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Section(header: Text("Background Color")) {
                Picker("Background Color", selection: $settingsData.bgColor) {
                    ForEach(BackgroundColor.allCases, id: \.self) { color in
                        Text(color.rawValue.capitalized).tag(color)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Font Color")) {
                Picker("Font Color", selection: $settingsData.fontColor) {
                    ForEach(FontColor.allCases, id: \.self) { color in
                        Text(color.rawValue.capitalized).tag(color)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Spacer()
        }
        .padding(20)
        .background(settingsData.bgColor.color)
    }
}

#Preview {
    SettingsView()
        .environmentObject(ModelData())
        .environmentObject(SettingsData())
}
