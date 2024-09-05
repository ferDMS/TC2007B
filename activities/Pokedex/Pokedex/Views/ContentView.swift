//
//  ContentView.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(ModelData.self) var modelData
    var pokemonList: [Pokemon] {
        modelData.pokemonList
    }
    
    var body: some View {
        
        // VStack for background color
        VStack (alignment: .leading) {
            
            VStack {
                // For background color in the entire screen
                HStack {Spacer()}
                
                // For the List
                PokemonList()
            }
            
        } // VStack for background color
        .background(Color.pokeWhite)
        .ignoresSafeArea()
    }

}

#Preview {
    ContentView()
        .environment(ModelData())
}
