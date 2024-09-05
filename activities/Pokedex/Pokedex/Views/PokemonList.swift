//
//  PokemonList.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
//

import SwiftUI

struct PokemonList: View {
    
    @Environment(ModelData.self) var modelData
    
    var pokemonList: [Pokemon] {
        modelData.pokemonList
    }
    
    var body: some View {
        NavigationSplitView {

            List {
                
                // Developer info
                HStack {
                    Text("by Fernando Monroy")
                        .foregroundColor(Color.pokeDarkBlue)
                        .opacity(0.5)
                    
                    Spacer()
                    
                    Text("A01750536")
                        .foregroundColor(Color.pokeDarkBlue)
                        .opacity(0.5)
                }
                .padding(.horizontal)
                
                // Heading
                Image("pokemon title")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                ForEach (pokemonList.indices, id: \.self) { index in
                    let pokemon = pokemonList[index]
                    NavigationLink {
                        PokemonDetail(pokemon: pokemon)
                    } label: {
                        PokemonRow(pokemon: pokemon)
                    }
                    
                }
                .listStyle(PlainListStyle()) // Remove extra styling in list
                
                if pokemonList.isEmpty {
                    Text("Error fetching data :(")
                }
                
            }
        } detail: {
            Text("Select a pokemon")
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    PokemonList()
        .environment(ModelData())
}
