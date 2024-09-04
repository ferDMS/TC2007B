//
//  Pokemon.swift
//  Pokedex
//
//  Created by PEZ on 03/09/24.
//

import Foundation

// PaginationResponse struct is just used to parse the response of whatever we asked for when we are requestion multiple elements.
// It's like a higher-level struct with which parse the entire JSON response, and from there start breaking down each element requested.
struct PaginationResponse: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [InfoBrief]
}

// To parse the PaginationResponse
// We basically get a URL to the actual resource we want
struct InfoBrief: Codable {
    var name: String
    var url: String
}

// Pokemon struct to save data from
class Pokemon: Codable, Identifiable {
    
    // Static properties, the data we are trying to obtain from the JSON
    var id: Int
    var name: String
    var sprites: Sprites
    var height: Double
    var weight: Double
    
    
    // Properties to obtain Type related info
    var types: [TypeBrief]
    struct TypeBrief: Codable {
        var type: InfoBrief
    }
    struct Type_: Codable {
        var damage_relations: [damage_relation]
        struct damage_relation: Codable {
            var no_damage_to: [InfoBrief]
            var no_damage_from: [InfoBrief]
        }
    }
    var typesInfo: [Type_] {
        var infoBriefList : Array<InfoBrief> = []
        for typeBrief in types {
            infoBriefList.append(typeBrief.type)
        }
        return fetchManyInfoBrief(infoBriefList: infoBriefList)
    }
    
    
    // Properties to obtain Species related info
    var species: InfoBrief
    struct Species: Codable {
        var flavor_text_entries: [flavor_text_entry]
        struct flavor_text_entry: Codable {
            var flavor_text: String
            var language: InfoBrief
        }
    }
    var speciesInfo: Species? {
        fetchOneInfoBrief(infoBrief: species)
    }
    
    
    // Properties to obtain Abilities related info
    var abilities: [AbilityBrief]
    struct AbilityBrief: Codable {
        var ability: InfoBrief
    }
    struct Ability: Codable {
        var effect_entries: [EffectEntry]
        struct EffectEntry: Codable {
            var short_effect: String
            var language: InfoBrief
        }
    }
    var abilitiesInfo: [Ability] {
        var infoBriefList : Array<InfoBrief> = []
        for abilityBrief in abilities {
            infoBriefList.append(abilityBrief.ability)
        }
        return fetchManyInfoBrief(infoBriefList: infoBriefList)
    }
    
    
    var imgUrl: String {
        self.sprites.other.officialArtwork.front_default
    }
    
    var small_text: String {
        return self.speciesInfo?.flavor_text_entries.first?.flavor_text ?? ""
    }
    
    
    // Properties to obtain the Image and related info
    struct Sprites: Codable {
        var other: Other
        struct Other: Codable {
            // In this case, we are looking for the object "OfficialArtwork"
            var officialArtwork: OfficialArtwork
            // We use coding keys so that we can map Swift variable names to different property names in the JSON
            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }
            struct OfficialArtwork: Codable {
                // Inside "OfficialArtwork" there should be a "front_default", the image we want
                var front_default: String
            }
        }
    }
}


/*
 New Swift knowledge I learned
 
 - Closures are basically the same as lambda functions from other languages.
 - The completion parameter is used to define a callback function, which is another function to be called at some point inside the function we were originally calling
 - Because we want to call the callback function in an asynchronic process, which means the original function might have already returned by the time we get to the point inside our async process at which we call the callback function. This is why we need to set the @escaping attribute. This way, we tell swift that we are expecting the closure to be executed even after the original function ends.
*/


// Function to get the information for a single pokemon, and returning it in a Pokemon object
func getOnePokemonInfo<T: Codable>(urlStr: String, completion: @escaping (T?) -> Void) {
    
    // Remember:
    // When we call from the getAllPokemonInfo, closure should append the info to a list of type T
    // When we call by itself, closure should save the info to a variable of type T
    
    // Make sure the URL is valid
    guard let url = URL(string: urlStr) else {
        print("Invalid URL")
        completion(nil) // Call completion with nil if unsuccessful
        return
    }
    
    // Start the data task to fetch the Pokemon
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // Unwrap `data` to check whether we got it or not
        // This notation means we are checking whether data is nil or not. If it has a value, just assign it, if it is nil, then we run the else block
        guard let data = data else {
            // If there's an error, print it
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("No data received")
            }
            completion(nil) // Call completion with nil if unsuccessful
            return
        }
        
        // Try to decode the data into a Pokemon object
        do {
            let pokemonInfo = try JSONDecoder().decode(T.self, from: data)
            completion(pokemonInfo) // Call the completion handler with the pokemon if successful
        } catch {
            print("Decoding error: \(error)")
            completion(nil) // Call completion with nil if unsuccessful
        }
    }
    
    // Start the task
    task.resume()
    
    // We always return void
    // We are not "returning" the Pokemon, rather "executing" whatever instruction we were commanded to do with the obtained info.
}


// Overloading so we can call the same function, but with id as parameter instead of url
func getOnePokemonInfo<T: Codable>(id: Int, endpoint: String, completion: @escaping (T?) -> Void) {
    let urlStr = "https://pokeapi.co/api/v2/\(endpoint)/\(id)"
    getOnePokemonInfo<T>(urlStr: urlStr, completion: completion)
}


// Function to get a list of 20 Pokemon objects, correctly initialized with their information
func getManyPokemon(completion: @escaping ([Pokemon]) -> Void) {
    // The list of Pokemon info we'll return
    var pokemonInfoList: [Pokemon] = []
    
    // Make sure the URL is valid
    guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
        completion(pokemonInfoList) // Call completion with an empty list if unsuccessful
        return
    }
    
    // Start the data task to fetch the list of Pokemon info
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // Check if we got data
        guard let data = data else {
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("No data received")
            }
            completion(pokemonInfoList) // Call completion with an empty list if unsuccessful
            return
        }
        
        // Try to decode the data into a list of pokemon briefs (name, url)
        do {
            let pagination = try JSONDecoder().decode(PaginationResponse.self, from: data)
            let pokemonInfoBriefList = pagination.results
            
            // Fetch each pokemon by its url
            let group = DispatchGroup()
            
            for pokemonInfoBrief in pokemonInfoBriefList {
                group.enter()
                
                // Call the getPokemon function by url
                getOnePokemonInfo(urlStr: pokemonInfoBrief.url) { (pokemonInfo: Pokemon?) in
                    // This is the closure, where we get the pokemon and append it
                    // We only append it if we successfully obtained it
                    if let pokemonInfo = pokemonInfo {
                        pokemonInfoList.append(pokemonInfo)
                    }
                    group.leave()
                }
            }
            
            // Wait for all tasks to finish before declaring the final list
            group.notify(queue: .main) {
                completion(pokemonInfoList) // This runs only after all tasks are done
            }
            
        } catch {
            print("Decoding error: \(error)")
            completion(pokemonInfoList)
        }
    }
    
    // Start the task
    task.resume()
}


func loadPokemon(filename: String) -> Pokemon? {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
        // If resource doesn't exist or there's an error no pokemon is returned
        return nil
    }
    
    do {
        // Load the data from the file
        let data = try Data(contentsOf: url)
        
        // Decode the JSON data into a Pokemon object
        let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
        return pokemon
        
    } catch {
        
        // Print the error and return nil if decoding fails
        print("Error decoding JSON: \(error)")
        return nil
    }
}


func fetchOneInfoBrief<T: Codable>(infoBrief : InfoBrief) -> T? {
    var info : T?
    let group = DispatchGroup()
    group.enter()
    getOnePokemonInfo<T>(urlStr: infoBrief.url) {fetchedInfo in
        info = fetchedInfo
        group.leave()
    }
    group.wait()
    return info
}


func fetchManyInfoBrief<T: Codable>(infoBriefList: [InfoBrief]) -> [T] {
    var results = [T]()
    let group = DispatchGroup()

    for infoBrief in infoBriefList {
        group.enter()
        getOnePokemonInfo<T>(urlStr: infoBrief.url) { (fetchedInfo : T?) in
            if let info = fetchedInfo {
                results.append(info)
            }
            group.leave()
        }
    }
    group.wait()
    return results
}
