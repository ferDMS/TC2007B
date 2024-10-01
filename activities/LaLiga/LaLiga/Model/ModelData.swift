//
//  ModelData.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
//

import Foundation

@Observable
class ModelData {
    var matches: [MatchModel] = []
    
    init() {
        loadMatches()
    }
    
    private func loadMatches() {
        guard let url = Bundle.main.url(forResource: "LaLiga", withExtension: "json") else {
            print("Failed to locate LaLiga.json in bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            matches = try decoder.decode([MatchModel].self, from: data)
        } catch {
            print("Failed to load and decode LaLiga.json: \(error)")
        }
    }
}