//
//  ContentView.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//
import SwiftUI

struct ContentView: View {
    @State private var bgColor: BackgroundColor = .brown
    @State private var fontColor: FontColor = .black
    
    var body: some View {
        VStack {
            DashboardView(bgColor: bgColor, fontColor: fontColor)
                .background(bgColor.colors[0])
                .foregroundColor(fontColor.color)
        }
        .onAppear {
            setDefaultUserSettings()
            let (bgColor, fontColor) = loadUserSettings()
            self.bgColor = bgColor
            self.fontColor = fontColor
        }
    }
}
    
    #Preview {
        ContentView()
            .environment(ModelData())
    }
