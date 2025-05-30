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
    
    // Picker
    @State private var pickerValue : Int = 1
    @State private var colorStr = "Red" // Default is red
    
    // Slider
    @State private var sliderValue : Double = 50.0
    @State private var isEditingSlider : Bool = false
    @State private var sliderColor : Color = Color(red: 125/255, green: 0, blue: 0)
    
    // Toggle
    @State private var toggleValue : Bool = false
    
    // List of colors
    @State private var colorList : [Color] = []
    
    func updateColorString() {
        let newColorValue = 0.5 + sliderValue/(255*2)
        
        if pickerValue == 1 {
            colorStr = "Red"
            sliderColor = Color(red: newColorValue, green: 0.1, blue: 0.1)
        } else if pickerValue == 2 {
            colorStr = "Green"
            sliderColor = Color(red: 0.1, green: newColorValue, blue: 0.1)
        } else {
            colorStr = "Blue"
            sliderColor = Color(red: 0.1, green: 0.1, blue: newColorValue)
        }
    }
    
    var body: some View {
        // VStack for background color
        VStack {
            VStack(alignment: .leading) {

                Text("Color Palette Generator 🎨")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x1E201E))
                
                ColorConfigView
                
                ColorSavedView
                       
                Spacer()
            }
        }
        .padding()
        .background(Color(hex: 0xECDFCC))
    }
    
    var ColorConfigView: some View {
        VStack(alignment: .leading) {
            Text("Color config")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Divider()
            
            Text("Select a primary color")
                .font(.body)
                .padding(.top, 20)
            
            // Para seleccionar un item de una lista
            Picker(selection: $pickerValue, label: Text("Selector")) {
                Text("Red").tag(1)
                Text("Green").tag(2)
                Text("Blue").tag(3)
            }
                .pickerStyle(.segmented)
            //  .pickerStyle(.wheel)
                .onChange(of: pickerValue) {
                    pickerValue = pickerValue
                    updateColorString()
                }
            
            Text("Change intensity")
                .padding(.top, 20)
        
            Slider(
                value: $sliderValue,
                in: 0...255,
                onEditingChanged: { editing in
                    isEditingSlider = editing
                }
            )
            .tint(sliderColor)
            .onChange(of: sliderValue) {
                if isEditingSlider {
                    updateColorString()
                }
            }
            
            HStack {
                Button("Save color") {
                    colorList.append(sliderColor)
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(sliderColor)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.top, 20)
            }
        }
    }
    
    var ColorSavedView: some View {
        VStack(alignment: .leading) {
            Text("Saved colors")
                .padding(.top, 20)
                .font(.title2)
                .fontWeight(.bold)
            
            Divider()
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(Array(colorList.enumerated()).reversed(), id: \.offset) { index, color in
                        Text("Color \(index + 1)")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .frame(width: 200, height: 200)
                            .background(color)
                    }
                }
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    ContentView()
}
