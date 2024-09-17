//
//  ContentView.swift
//  DefaultsApp
//
//  Created by PEZ on 17/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationStack {
                Button("Guardar MJ") {
                    UserDefaults.standard.setValue("Michael Jordan", forKey: "nombreJugador")
                    UserDefaults.standard.setValue(23, forKey: "numeroJugador")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Guardar LJ") {
                    UserDefaults.standard.setValue("LeBron James", forKey: "nombreJugador")
                    UserDefaults.standard.setValue(23, forKey: "numeroJugador")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Guardar KB") {
                    UserDefaults.standard.setValue("Kobe Bryant", forKey: "nombreJugador")
                    UserDefaults.standard.setValue(24, forKey: "numeroJugador")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Borrar") {
                    UserDefaults.standard.removeObject(forKey: "nombreJugador")
                    UserDefaults.standard.removeObject(forKey: "numeroJugador")
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink("Ir a Detalle"){
                    DetalleView()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
