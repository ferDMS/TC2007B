//
//  ModelData.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
//

import Foundation

@Observable
class ModelData {
    var pokemonList: [Pokemon] = []

    init() {
        load { pokemonList in
            self.pokemonList = pokemonList
        }
    }
    
    func load(completion: @escaping ([Pokemon]) -> Void) {
        getManyPokemon { pokemonList in
            completion(pokemonList)
        }
    }
}
