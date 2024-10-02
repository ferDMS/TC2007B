//
//  ContentView.swift
//  PruebasMapas
//
//  Created by PEZ on 02/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var marcadoresList: [Marcador] = [
        Marcador(nombre: "Tacos", coordinate: .init(latitude: 25.6407, longitude: -100.27847), colorMark: .orange),
        Marcador(nombre: "Gym", coordinate: .init(latitude: 25.6802877, longitude: -100.2724652))
    ]
    
    var body: some View {
        VStack {
            Text("Ejemplo Mapas")
            MapaView(latitud: 25.67507, longitud: -100.31847, customMark: marcadoresList, showPosicion: true)
                .frame(height: 300)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
