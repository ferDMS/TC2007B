//
//  PokedexApp.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
//

import SwiftUI

@main
struct PokedexApp: App {
    
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
