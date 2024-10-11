//
//  SettingsView.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//
import SwiftUI

struct CustomMatchView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var settingsData: SettingsData
    
    var body: some View {
        ScrollView {
            Text("Add Match")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.vertical, 5)
            
            // Functionality to add match
            AddMatchView()
                .padding(.horizontal, 20)
                .frame(width: .infinity, height: (400))
            
            Text("Custom Matches")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            MatchTableView(filter: {match in match.isCustom})
                .frame(width: .infinity, height: (400))
            
            Spacer()
        }
        .padding(20)
        .background(settingsData.bgColor.color)
    }
}

#Preview {
    CustomMatchView()
        .environmentObject(ModelData())
        .environmentObject(SettingsData())
}
