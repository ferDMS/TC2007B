// Swift introduction

import UIKit

// Code written at global scope is used as the entry point for the program
// Also, there's no need to write semicolons at the end of every statement
// Like python, unlike C

// Traditional Hello, world!
print("Hello, world!")

// Variables
// Don't need to be defined (with a value) at compile time
// Can't change type once declared or infered (unlike Python)
var myVar = 42
myVar = 50
let myConst = 42

// Explicit definition
var myInt : Int = 4
let myDouble : Double = 4

// String operations
let pre = "Your score is "
var object = 100
var label = pre + String(object)
label = "Im kidding! It's not \(object)" // String functionality
label = """
OR am I...
>   <
  U       hehe
"""

// Arrays and dictionaries (same as Python, but always with brackets)
// Dictionaries are unordered (unlike Python's default)
var fruits = ["strawberries", "limes", "tangerines"]
fruits[1] = "grapes"
print(fruits)

var chiles = [
    "Jalapeño": "Rancio",
    "Poblano": "Buenazo",
    "Chipotle": "Mega GOD",
    "Serrano": "Buenazo",
    "Habanero": "Picosin",
]

// Accesing a value in a dict returns an optional type because the key might not exist
// So, in order to print we must tell Swift we are sure that the key exists via the !
// This way we don't pass an optional to the print statement, which would be invalid
print(chiles["Chipotle"]!)

// Initializer of empty arrays and dicts
let emptyArray: [String] = []
let emptyDict: [String: Float] = [:]

// Conditionals and loops
// Optional parentheses for conditions
// Required braces for body
var good_reviews = 0
for (chile, review) in chiles {
    if ["Buenazo", "Mega GOD"].contains(review) {
        good_reviews += 1
    }
}
print("Chiles have \(good_reviews) good reviews!")

// Optionals, defined with ?
// Can contain either its supposed value or a nil (no value)
var optionalName: String? = "John Doe"
var greeting =  "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}
// If there is no name defined, then condition returnes false
// and the greeting is never changed (remains with no name)
// If the name is defined, it also defines the `name` variable

// To define a default value in case we try to use an optional and fail, we can use ??
let sureName = "Abraham"
let nickname: String? = nil
let goodby = "Bye \(nickname ?? optionalName ?? sureName)"

// Switch
switch sureName {
case "Mohammed":
    print("Popular name")
case "Joaquin":
    print("Bad name")
case "Daniel":
    print("Epic name")
default:
    print("Aight name")
}

// While
var n = 2
while n < 100 {
    n *= 2
}
print(n)

// Ranges (used in For loops to have an index)
let closed_range = 0...5 // Yes including 5
let range_limited = 0..<5 // Not including 5

// Functions
func greet(person: String, day: Int) -> String {
    return "Hello \(person), today is not the \(day)"
}
greet(person: sureName, day: myVar)

// Tuples: Can be accesed by name or by index when we define it so in the signature
// We can return multiple values from a function using a tuple
func calc_range(x: Double, y: Double, n: Double) -> (x_arr: [Double], y_arr: [Double]) {
    var x_array = Array(stride(from: 0.0, to: x, by: n))
    var y_array = Array(stride(from: 0.0, to: y, by: n))
    
    return (x_array, y_array)
}
var graph_ranges = calc_range(x: 10, y: 100, n: 200)
print(graph_ranges.x_arr[100])

