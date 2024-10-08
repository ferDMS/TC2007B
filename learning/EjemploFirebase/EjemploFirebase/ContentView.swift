//
//  ContentView.swift
//  EjemploFirebase
//
//  Created by PEZ on 08/10/24.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    // Conexión a base de datos Firestore
    private let db = Firestore.firestore()
    
    @State private var listaPendientes : [Pendiente] = []
    
    func addData(pendienteItem : Pendiente) {
        // Variable vacía, no nos importa lo que nos regresa
        let _ = db.collection("pendientes").addDocument(data: ["nombre": pendienteItem.nombre, "notas": pendienteItem.notas])
        listaPendientes.append(pendienteItem)
    }
    
    func getData() {
        var listaPendientesIn: [Pendiente] = []
        
        db.collection("pendientes").order(by: "nombre").getDocuments{(querySnapshot, err) in
            if err != nil {
                print ("Error en la llamada a firebase: \(err!)")
            }
            else {
                if querySnapshot != nil {
                    for documentItem in querySnapshot!.documents {
                        let data = documentItem.data()
                        let id = documentItem.documentID
                        let nombre = data["nombre"] as! String
                        let notas = data["notas"] as! String
                        // Generar nuevo pendiente con documento
                        let nuevoPendiente = Pendiente(id: id, nombre: nombre, notas: notas)
                        listaPendientesIn.append(nuevoPendiente)
                    }
                    listaPendientes = listaPendientesIn
                    print(listaPendientes)
                } else {
                    print("No hay datos")
                }
            }
        }
    }
    
    func updateData(pendienteItem: Pendiente) {
        if let docId = pendienteItem.id {
            let pendiente = db.collection("pendientes").document(docId)
            pendiente.updateData(["nombre": "Nuevo nombre raaahhh"])
        } else {
            print("Error, ID no válido")
        }
    }
    
    func deleteData(pendienteItem: Pendiente) {
        if let docId = pendienteItem.id {
            let pendiente = db.collection("pendientes").document(docId)
            pendiente.delete()
        } else {
            print("Error, ID no válido")
        }
    }
    
    var body: some View {
        VStack {
            Text("Bienvenido a Ejemplo Firebase")
            
            Button("Agregar pendiente") {
                var pendiente1 = Pendiente(nombre: "Juan", notas: "Comprar la leche")
                addData(pendienteItem: pendiente1)
            }.buttonStyle(.borderedProminent)
            
            Button("Obtener datos") {
                getData()
            }.buttonStyle(.borderedProminent)
            
            Button("Actualizar primer dato") {
                if listaPendientes.isEmpty == false {
                    updateData(pendienteItem: listaPendientes.first!)
                } else {
                    print("No pendiente to update")
                }
            }.buttonStyle(.borderedProminent)
            
            Button("Eliminar primer dato") {
                if listaPendientes.isEmpty == false {
                    deleteData(pendienteItem: listaPendientes.first!)
                } else {
                    print("No pendiente to update")
                }
            }.buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
