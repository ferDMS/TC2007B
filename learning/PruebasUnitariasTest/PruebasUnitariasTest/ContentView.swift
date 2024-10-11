//
//  ContentView.swift
//  PruebasUnitariasTest
//
//  Created by PEZ on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State public var base: Double
    @State public var tip: Double
    @State public var total = 0.0
    
    
    func calc() -> Double {
        if (tip < 0) {
            return 0.0
        } else {
            let total = base + base * (tip / 100)
            return total
        }
    }
    
    var body: some View {
        VStack {
            Text("Unit tests")
            
            Button("Calc") {
                total = calc()
            }
            .buttonStyle(.borderedProminent)
            
            Text("Total: \(total)")
        }
        .padding()
    }
}

#Preview {
    ContentView(base: 100, tip: 10)
}
