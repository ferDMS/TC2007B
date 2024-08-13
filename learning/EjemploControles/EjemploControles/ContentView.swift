//
//  ContentView.swift
//  EjemploControles
//
//  Created by PEZ on 13/08/24.
//

import SwiftUI

// Snippet online
extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

struct ContentView: View {
    
    @State private var pickerValue : Int = 1
    @State private var colorStr = "Yellow" // Default is yellow
    
    @State private var sliderValue : Double = 50.0
    
    @State private var toggleValue : Bool = false
    
    func showColorPalette(color : Int) {
        
    }
    
    
    
    var body: some View {
        
        // VStack for background color
        VStack {
            VStack(alignment: .leading) {
                Spacer()
                Text("Color Palette Generator 🎨")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x1E201E))
                
                Text("Select a primary color")
                    .font(.body)
                    .padding(.top, 20)
                
                // Para seleccionar un item de una lista
                Picker(selection: $pickerValue, label: Text("Selector")) {
                    Text("Red").tag(1)
                    Text("Yellow").tag(2)
                    Text("Blue").tag(3)
                }
                    .pickerStyle(.segmented)
                //  .pickerStyle(.wheel)
                    .onChange(of: pickerValue) {
                        showColorPalette(color: pickerValue)
                    }
                
                Text("Change intensity")
                    .padding(.top, 20)
            
                Slider(value: $sliderValue, in: 0 ... 100,
                       onEditingChanged: {editing in }).tint(Color(hex: 0x697565))
                
                Toggle("Inverse colors", isOn: $toggleValue) 
                    .tint(Color(hex: 0x1E201E))
                    .onChange(of: toggleValue) {
                    oldValue, newValue in
                }
                    .padding(.top, 20)
                       
                Spacer()
                
                
            }
        }
        .padding()
        .background(Color(hex: 0xECDFCC))
    }
}

#Preview {
    ContentView()
}
