//
//  ContentView.swift
//  EjemploNavegacion
//
//  Created by PEZ on 15/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "soccerball")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                Text("Hello, world!")
                
                NavigationLink("VerDetalle") {
                    DetalleView()
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                NavigationLink(destination: DetalleView())
                {
                    Image(systemName: "soccerball")
                }
            }
            .padding()
            
            // Like a title on top
            // It's what is shown in the "back" button
            .navigationBarTitle("Volver")
            // Hide it
            .toolbar(.hidden)
        }
    }
}

#Preview {
    ContentView()
}
