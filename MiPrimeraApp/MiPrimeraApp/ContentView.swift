//
//  ContentView.swift
//  MiPrimeraApp
//
//  Created by PEZ on 08/08/24.
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
    
    @State private var nombre = ""
    @State private var mensajeFinal = ""
    
    var body: some View {
        // Stack grabs all its available space considering other spacers and paddings. This is vertical
        VStack {
            // This one would be horizontal.
            // HStack{Spacer()}
            
            // The main VStack
            VStack (alignment: .leading) {
                
                // This is the first spacer used to center vertically.
                Spacer()
                
                HStack {
                    // So now this stack is not
                    VStack (alignment: .leading) {
                        Text("Welcome 👋")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.vertical, 5)
                        
                        Text("Please enter your name")
                            .font(.title3)
                        
                        TextField("Enter here", text: $nombre)
                            .frame(height: 40)
                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 6))
                            .background(
                                RoundedRectangle (cornerRadius: 10)
                                    .stroke(.black, lineWidth: 2)
                                    
                            )
                            .padding(.vertical)
                        
                        Button("Greet!") {
                            mensajeFinal = "Nice you have your here, " + nombre
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color(hex: 0xe9dbb1))
                        .foregroundColor(.black)
                        .padding(.vertical)
                        
                        Text(mensajeFinal)
                            .font(.title3)
                    }
                    
                    // To put to the left and to extend to extend as much as possible horizontally
                     Spacer()
                }
                
                // This is the second spacer used to center vertically.
                Spacer()
            }
        }
        .padding()
        .background(Color(hex: 0xfbf8ef))
    }
}

#Preview {
    ContentView()
}
