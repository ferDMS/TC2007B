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
            // For background color in the entire screen
            HStack {Spacer()}
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                Button("Get one pokemon") {
                    // API call with response in console
                    let pikachuUrl = "https://pokeapi.co/api/v2/pokemon/pikachu/"
                    getOnePokemonInfo<Pokemon>(urlStr: pikachuUrl){fetchedPokemon in
                        // If something failed, pokemon will be nil
                        // If all good, pokemon will have value
                        pokemon = fetchedPokemon
                    }
                }
                
                // Confirm we got a valid pokemon
                if let pokemon = pokemon {
                    Text(pokemon.name)
                    Text(pokemon.types.first?.type.name ?? "No type")
                }
                
                Text(pokemon?.small_text ?? "")
                
                ScrollView {
                    // At the start pokemonList is empty, but after everything is loaded it gets populated with pokemons
                    ForEach(pokemonList.indices, id: \.self) { index in
                        let pokemon = pokemonList[index]
                        PokemonRow(pokemon: pokemon)
                    }
                }
            }
            
        } // VStack for background color
        .padding()
        .background(Color.pokeWhite)
    }

}

#Preview {
    ContentView()
        .environment(ModelData())
}
