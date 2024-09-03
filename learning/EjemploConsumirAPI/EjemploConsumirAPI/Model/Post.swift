//
//  Post.swift
//  EjemploConsumirAPI
//
//  Created by PEZ on 03/09/24.
//

import Foundation

// Codable: To decode and encode from JSON
// Identifiable: To use an id
struct Post : Codable, Identifiable {
    let userId, id: Int
    let title, body: String
    
    // "Computed" property
    // In case we don't have an id variable to use with Identifiable
//    var id: Int {
//        return userId
//    }
    
}
