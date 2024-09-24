//
//  ContentView.swift
//  EjemploGraficas
//
//  Created by PEZ on 24/09/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    let dataBarChart: [Comida] = [
        Comida(id:1, tipo: "Pizza", votos: 10),
        Comida(id:2, tipo: "Hamburguesa", votos: 15),
        Comida(id:3, tipo: "Tacos", votos: 7)
    ]

    let dataLinesXY = [
        Punto(x:1, y:20),
        Punto(x:2, y:100),
        Punto(x:3, y:60)
    ]
    
    let dataPie = [
        (6.0, Color.red),
        (3.0, Color.blue),
        (1.0, Color.yellow),
        (4.0, Color.green)
    ]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Ejemplo Gráficas")
            
//            Chart {
//                BarMark(
//                    x: .value("Valor X", "Tacos"),
//                    y: .value("Valor Y", 100)
//                )
//                BarMark(
//                    x: .value("Valor X", "Tostadas"),
//                    y: .value("Valor Y", 50)
//                )
//                BarMark(
//                    x: .value("Valor X", "Tamales"),
//                    y: .value("Valor Y", 150)
//                )
//            }
            
            Chart(dataBarChart) {item in
                BarMark(
                    x: .value("Comida", item.tipo),
                    y: .value("Votos", item.votos)
                )
            }
            .frame(width:300 , height: 200)
            .padding(5)
            
            Chart(dataLinesXY) {item in
                LineMark(x: .value("Meses", item.x), y: .value("Votos", item.y))
            }
            .frame(width:300 , height: 200)
            .padding(5)

            PieChartView(slices: dataPie)
            
            PieChartView(slices: dataPie, isDonut: true)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
