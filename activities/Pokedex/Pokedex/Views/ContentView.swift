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
    
    @State private var pokemon : Pokemon? = nil
    
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
    }

}

#Preview {
    ContentView()
        .environment(ModelData())
}
