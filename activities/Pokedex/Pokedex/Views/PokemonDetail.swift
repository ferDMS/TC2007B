//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
//

import SwiftUI

struct PokemonDetail: View {
    
    var pokemon: Pokemon
    
    var body: some View {
        ForEach(pokemon.abilitiesInfo.indices, id: \.self) { index in
            Text(pokemon.abilities[index].ability.name.capitalized).font(.title)
            
            let ability = pokemon.abilitiesInfo[index]
            if let effectEntry = ability.effect_entries.first(where: { $0.language.name == "en" }), !effectEntry.short_effect.isEmpty {
                Text("\(effectEntry.short_effect)\n")
            }
        }
    }
}

#Preview {
    if let pokemon = loadPokemon(filename: "pikachu") {
        PokemonDetail(pokemon: pokemon)
    } else {
        Text("Couldn't load pokemon")
    }
}
