//
//  PokemonListItem.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
//

import SwiftUI

struct PokemonRow: View {
    
    var pokemon: Pokemon
    var typeList: [String] {
        pokemon.types.map { $0.type.name }
    }
    
    var body: some View {
        
        HStack {
            
            // Image
            ZStack {
                AsyncImage(url: URL(string: pokemon.imgUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    Color.white
                }
            }
            .frame(width: 100, height: 100)
            
            
            // Info
            HStack {
                VStack (alignment: .leading) {
                    
                    
                    // Name
                    Text(pokemon.name.capitalized)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, -5)
                    
                    HStack {
                        // Types
                        ForEach(typeList, id: \.self) { type in
                            Text(type.capitalized)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(pokemonTypeColors[type]) // Background color for the tag
                                .cornerRadius(8) // Rounded corners for the tag
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 2) // Border color and width
                                )
                        }
                    }
                }
            }
            
            // Spacing
            HStack {Spacer()}
        }
        .padding(.vertical, 0)
    }
}

#Preview {
    if let pokemon = loadPokemon(filename: "pikachu") {
        PokemonRow(pokemon: pokemon)
    } else {
        Text("Couldn't load pokemon")
    }
}
