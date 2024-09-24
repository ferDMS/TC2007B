//
//  ModeloPunto.swift
//  EjemploGraficas
//
//  Created by PEZ on 24/09/24.
//

import Foundation

struct Punto: Identifiable {
    let id: Int
    let x: Int
    let y : Double
    
    init (x: Int, y: Double) {
        self.id = x
        self.x = x
        self.y = y
    }
}
