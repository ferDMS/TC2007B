//
//  ContentView.swift
//  Pokemon2024
//
//  Created by PEZ on 15/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            ZStack{
                Image("base")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                
                PokeFotoView()
                    .frame(width: 150)
                    .offset(y:120)
                                
            }
            .padding(.bottom, 100)
            
            DatosView()
                .padding(20)
            
            MasDatosView()
                .padding(20)
            
            Spacer()
        }
        // Shouldn't use it ever, but interesting to know
        // .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
