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
    
    func calc(base: Double, tip: Double) -> Double {
        let amounts = inputTextFields(base: base, tip: tip)
        let tip = amounts[1]
        let base = amounts[0]
        
        if tip < 0 || tip > 100 {
            return tip.isNaN ? 0 : 0
        }
        return base + base * (tip / 100)
    }
    
    func inputTextFields(base: Double, tip: Double) -> [Double] {
        // Define base and tip
        return [Double(basePrice) ?? 0.0, Double(tipPercentage) ?? 0.0]
    }
    
    // Input for base price
    @State public var basePrice: String = ""
    
    // Input for tip percentage
    @State public var tipPercentage: String = ""
    
    var body: some View {
        VStack {
            Text("Unit tests")
            
            // Input
            VStack {
                TextField("Base price", text: $basePrice)
                TextField("Tip percentage", text: $tipPercentage)
            }
            
            Button("Calc") {
                total = calc(base: base, tip: tip)
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
