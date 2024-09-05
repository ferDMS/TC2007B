//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
//

import SwiftUI

struct PokemonDetail: View {
    
    // Pokemon information to display
    var pokemon: Pokemon
    
    // To display the background color
    var firstType: String {
        pokemon.types.first?.type.name ?? "unknown"
    }
    
    var typeColor : Color {
        pokemonTypeColors[firstType] ?? pokemonTypeColors["unknown"]!
    }
    
    // To display the characteristics
    var characteristics: [String: String] {[
        "Height": "\(pokemon.height / 10) m",
        "Weight": "\(pokemon.weight / 10) kg",
        "Initial Happiness": "\((pokemon.speciesInfo?.base_happiness ?? 70) * 100 / 255)/100"
    ]}
    let charViewOrder = ["Height", "Weight", "Initial Happiness"]
    
    
    var body: some View {
        
        ScrollView {
            
            ZStack {
                // Background color
                typeColor
                    .opacity(0.6)
                
                VStack {
                    
                    // Image preview
                    ZStack {
                        // Image background color
                        Circle()
                            .foregroundColor(.white.opacity(0.5))
                        
                        // Getting image from url
                        AsyncImage(url: URL(string: pokemon.imgUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                            
                        } placeholder: {
                            Color.white
                        }
                        .shadow(radius: 10)
                        
                    }
                    .clipShape(Circle())
                    .frame(width: 250, height: 250)
                    .overlay {
                        Circle()
                            .stroke(.black, lineWidth: 4)
                            .frame(width: 250, height: 250)
                    }
                    .shadow(radius: 7)
                    .padding(.top, 80)
                    .padding(.bottom, 20)
                    
                    VStack {
                        
                        // Title (name)
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .shadow(color: .gray.opacity(0.4), radius: 2, x: 0, y: 2) // Adds a subtle shadow
                            .padding(.bottom, 5)
                            .padding(.top, 20)
                        
                        // Small fact
                        HStack {
                            Spacer()
                            Text("“\(pokemon.fact)”")
                                .font(.subheadline)
                                .italic()
                                .cornerRadius(5)
                                .padding(.horizontal, 10)
                                .padding(.bottom, 20)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        
                    }
                    .background(.white.opacity(0.5))
                    
                }
            }
            
            VStack(alignment: .leading) {
                
                Text("Characteristics")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                
                Divider()
                
                ForEach(charViewOrder, id: \.self) { key in
                    if let value = characteristics[key] {
                        Text("\(key): \(value)")
                            .font(.title3)
                            .padding(.bottom, 2)
                    }
                }
                
                
                
                Text("Abilities")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                
                Divider()
                
                ForEach(pokemon.abilitiesInfo.indices, id: \.self) { index in
                    Text(pokemon.abilities[index].ability.name.capitalized).font(.title2)
                    let ability = pokemon.abilitiesInfo[index]
                    
                    if let effectEntry = ability.effect_entries.first(where: { $0.language.name == "en" }), !effectEntry.short_effect.isEmpty {
                        Text("\(effectEntry.short_effect)\n")
                    }
                    
                }
            }
            .padding(25)
            
        }
        .background(typeColor.opacity(0.1))
        .ignoresSafeArea()
    }
        
}

#Preview {
    if let pokemon = loadPokemon(filename: "pikachu") {
        PokemonDetail(pokemon: pokemon)
    } else {
        Text("Couldn't load pokemon")
    }
}
