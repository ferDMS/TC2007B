//
//  ContentView.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var modelData = ModelData()
    @StateObject private var settingsData = SettingsData()
    
    init() {
        loadDefaultSettings()
    }
    
    var body: some View {
        VStack {
            DashboardView()
                .background(settingsData.bgColor.color)
                .foregroundColor(settingsData.fontColor.color)
                .environmentObject(modelData)
                .environmentObject(settingsData)
        }
    }
}

#Preview {
    ContentView()
}
