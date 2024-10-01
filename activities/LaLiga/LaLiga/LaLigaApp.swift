//
//  LaLigaApp.swift
//  LaLiga
//
//  Created by PEZ on 30/09/24.
//

import SwiftUI

@main
struct LaLigaApp: App {
    
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
