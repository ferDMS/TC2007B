import UIKit

// For JSON encoder-decoder
import Foundation
let jsonEncoder = JSONEncoder()

// Custom protocol without implementation
protocol Colored {
    // Properties
    var color: String { get }

    // Method to determine the color
    func determineColor() -> String
}

// CustomStringConvertible protocol: Give the class a string representation
// Equatable protocol: Give the class a comparison metric to be evaluated
// Codable: To encode and decode to and from JSON
struct Empleado : CustomStringConvertible, Equatable, Codable, Colored {
    
    var id: Int
    var nombre: String
    var apellidos: String
    var depto: String
    
    // For the custom Colored protocol
    var color: String {
        determineColor()
    }
    
    // For the CustomStringConvertible protocol
    var description: String {
        return "ID de empleado: \(id) - Su nombre: \(nombre) \(apellidos)"
    }
    
    init (id: Int, nombre: String, apellidos : String, depto : String) {
        self.id = id
        self.nombre = nombre
        self.apellidos = apellidos
        self.depto = depto
    }
    
    // For the Equatable protocol
    static func == (izq: Empleado, der: Empleado) -> Bool {
        return izq.id == der.id
    }
    
    // For the customed Colored protocol
    // Internal to make the implementation private (considering the property's signature is public)
    internal func determineColor() -> String {
        switch depto {
        case "NBA":
            return "Red"
        case "WNBA":
            return "Blue"
        case "ATP":
            return "Green"
        case "WTA":
            return "Yellow"
        default:
            return "White" // Default color if the department doesn't match any case
        }
    }
}

let emp1 = Empleado(id: 21, nombre: "Michael", apellidos: "Jordan", depto: "NBA")
let emp2 = Empleado(id: 22, nombre: "Michael", apellidos: "Jordan", depto: "NBA")
let emp3 = Empleado(id: 23, nombre: "LeBron", apellidos: "James", depto: "NBA")

// Using the CustomStringConvertible `description` implementation
print(emp1)

// Using the Equatable `==` method implementation
print(emp1 == emp2) // false

// Using the Codable protocol, we make it `inputable` to the jsonEncoder.encode() method
var listaEmpleados = [emp1, emp2, emp3]
do {
    let jsonData = try jsonEncoder.encode(listaEmpleados)
    let jsonString = String(data: jsonData, encoding: .utf8)
    print(jsonString!)
} catch {
    print("Error inesperado \(error)")
}

// Using the custom protocol method implementation
print("Color: \(emp1.color)")



//// Default implementation using protocol extension
//extension ColorProtocol {
//    func CalcColor() -> String {
//        return "Black"
//    }
//}
