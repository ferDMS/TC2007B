//
//  DetalleView.swift
//  DefaultsApp
//
//  Created by PEZ on 17/09/24.
//

import SwiftUI

struct DetalleView: View {
    
    @State private var nombre = ""
    @State private var numero = 0
    
    var body: some View {
        VStack {
            Text("Datos del jugador")
            Text("Nombre \(nombre)")
            Text("# \(numero)")
        }
        .onAppear(){
            if let nombreIn = UserDefaults.standard.string(forKey: "nombreJugador") {
                nombre = nombreIn
                numero = UserDefaults.standard.integer(forKey: "numeroJugador")
            }
            else{
                nombre = "No name"
                nombre = "No number"
            }
        }
    }
}

#Preview {
    DetalleView()
}
