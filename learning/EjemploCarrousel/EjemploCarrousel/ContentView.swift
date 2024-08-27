//
//  ContentView.swift
//  EjemploCarrousel
//
//  Created by PEZ on 27/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            TabView {
                //Poner imágenes con alto de 300
                Image(systemName: "figure.baseball")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                
                Image(systemName: "figure.open.water.swim")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)

                Image(systemName: "figure.volleyball")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)

                Image(systemName: "figure.tennis")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)

            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .frame(height: 430)

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
