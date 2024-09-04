//
//  PokemonListItem.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
//

import SwiftUI

struct PokemonRow: View {
    
    var pokemon: Pokemon
    
    var body: some View {
        
        VStack (alignment: .leading) {

            HStack {
                
                // Image
                ZStack {
                    Color.pokeLightGray
                        .frame(width: 128, height: 128)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                    AsyncImage(url: URL(string: pokemon.imgUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.white
                    }
                    .frame(width: 128, height: 128)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                }
                // Clip everything in frame
                .frame(width: 128, height: 128)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(10)
                
                VStack (alignment: .leading) {
                    // Name
                    Text(pokemon.name.capitalized)
                        .font(.title)
                    // Type(s)
                    Text("Type: \(pokemon.types.first?.type.name.capitalized ?? "")")
                    // Small description
                    Text("")
                    //                Text(pokemon.small_text + "Hola")
                    
                    
                    
                }
            }
        }
    }
}

#Preview {
    if let pokemon = loadPokemon(filename: "pikachu") {
        PokemonRow(pokemon: pokemon)
    } else {
        Text("Couldn't load pokemon")
    }
}
