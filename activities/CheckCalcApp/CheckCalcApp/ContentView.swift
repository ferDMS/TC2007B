//
//  ContentView.swift
//  CheckCalcApp
//
//  Created by PEZ on 13/08/24.
//

import SwiftUI

// Snippet online
extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

// Snippet online
// A method to hide the keyboard
func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

struct ContentView: View {
    
    // Variables to obtain input
    @State private var spendingInput : String = ""
    @State private var groupSizeInput : String = ""
    @State private var tipPercentageInput : String = ""
    @State private var freeForOne : Bool = false
    let defaultTip = 10.0
    
    // Variables to show validation errors
    @State private var isSpendingValid : Bool = true
    @State private var isGroupSizeValid : Bool = true
    @State private var isTipPercentageValid : Bool = true
    @State private var isFreeForOneValid : Bool = true
    
    
    // For picker wheel options
    let groupSizes : [String] = [""] + Array(1...20).map{ String($0) }
    
    // Final result variables
    @State private var errorText : String = ""
    @State private var showError : Bool = false
    @State private var showResult : Bool = false
    @State private var spentPerPersonOutput : String = ""
    @State private var randomPersonOutput : String = ""
    
    func isValidInput() -> Bool {
        isSpendingValid = Double(spendingInput) != nil
        isGroupSizeValid = !groupSizeInput.isEmpty
        isTipPercentageValid = tipPercentageInput.isEmpty || Double(tipPercentageInput) != nil
        isFreeForOneValid = !freeForOne || (freeForOne && isGroupSizeValid && Double(groupSizeInput)! > 1)
        
        return isSpendingValid && isGroupSizeValid && isTipPercentageValid && isFreeForOneValid
    }
    
    func calcResult() {
        let spending = Double(spendingInput)!
        var groupSize = Double(groupSizeInput)!
        let tipPercentage = tipPercentageInput.isEmpty ? defaultTip : Double(tipPercentageInput)!
        
        if freeForOne {
            let randomPerson = Int.random(in: 1...Int(groupSize))
            randomPersonOutput = String(randomPerson)
            
            // To make calculations with one person less
            groupSize -= 1
        }
        
        let spentPerPerson = (spending + spending * (tipPercentage/100)) / groupSize
        
        // Pay more than calculated with non-terminating calculations
        let roundedValue = ceil(spentPerPerson * 100) / 100
        
        spentPerPersonOutput = String(format: "%.2f", roundedValue)
        
        // Show result
        showResult = true
    }
    
    func runCalcInput() {
        if isValidInput() {
            calcResult()
            
        } else{
            errorText = ""
            
            if !isSpendingValid {
                errorText += "Provide a valid spending amount\n"
            }
            if !isGroupSizeValid {
                errorText += "\nChoose a valid group size\n"
            }
            if !isTipPercentageValid {
                errorText += "\nEnter a valid tip\n"
            }
            if !isFreeForOneValid {
                freeForOne = false
                errorText += "\nCan't Free-for-One a 1-sized group"
            }
            
            showError = true
        }
        
        hideKeyboard()
    }

    var body: some View {
        
        // VStack for background color
        VStack (alignment: .leading) {
            
            Text("Restaurant Check Calculator 🍔🧮")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: 0x1E201E))
            
            ScrollView {

                VStack (alignment: .center) {
                    
                    if showResult {
                        
                        Text("To pay per person:")
                            .font(.title3) // Custom size
                        
                        Text("$\(spentPerPersonOutput)")
                            .font(.system(size: 50, weight: .bold))
                            .padding(.bottom, -5)
                        
                        if freeForOne {
                            Text("Person \(randomPersonOutput) doesn't pay the bill! 🎉")
                                .padding(.top, 5)
                                .font(.body)
                        }
                        
                    }
                    
                }
                
                VStack {
                    
                    HStack {
                        HStack {
                            Text("💵 Spending")
                                .font(.title2)
                                .padding(.vertical)
                                .fixedSize()
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        
                        HStack {
                            ZStack(alignment: .leading) {
                                
                                TextField("00.00", text: $spendingInput)
                                    .frame(height: 40)
                                    .keyboardType(.decimalPad)
                                    .fontWeight(.bold)
                                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 10)) // Add leading padding to shift text right
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(hex: 0xf3ece0))
                                            .stroke(isSpendingValid ? .black : .red, lineWidth: 2)
                                        
                                    )
                                
                                // Dollar sign positioned to the left
                                Text("$")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black) // Color of the dollar sign
                                    .padding(.leading, 15)
                            }
                        }
                    }
                    .padding(.bottom)
                    
                    
                    HStack {
                        HStack {
                            Text("👥 Group Size")
                                .font(.title2)
                                .padding(.vertical)
                                .fixedSize()
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Picker("Group Size", selection: $groupSizeInput) {
                                ForEach(groupSizes, id: \.self) { size in
                                    Text(size).tag(size)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 120)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(hex: 0xf3ece0))
                                    .stroke(isGroupSizeValid ? .black : .red, lineWidth: 2)
                            )
                        }
                    }
                    .padding(.bottom)
                    
                    
                    HStack {
                        HStack {
                            Text("🛎 Tip")
                                .font(.title2)
                                .padding(.vertical)
                                .fixedSize()
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        
                        HStack {
                            ZStack(alignment: .trailing) {
                                
                                TextField("10", text: $tipPercentageInput)
                                    .frame(height: 40)
                                    .keyboardType(.decimalPad)
                                    .fontWeight(.bold)
                                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 10)) // Add leading padding to shift text right
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(hex: 0xf3ece0))
                                            .stroke(isTipPercentageValid ? .black : .red, lineWidth: 2)
                                        
                                    )
                                
                                // Percentage sign to the right
                                Text("%")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black) // Color of the dollar sign
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                    .padding(.bottom)
                    
                    HStack {
                        HStack {
                            Text("🎁 Free for One!")
                                .font(.title2)
                                .padding(.vertical)
                                .fixedSize()
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        
                        Toggle("", isOn: $freeForOne)
                            .tint(Color(hex: 0x1E201E))
                            .onChange(of: freeForOne) {
                            oldValue, newValue in
                                if showResult {
                                    runCalcInput()
                                }
                        }
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            runCalcInput()
                        }) {
                            Text("Calculate")
                                .font(.title)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color(hex: 0xdcc5a2))
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                        
                        Spacer()
                    }
                    
                    
                } // VStack
                .padding(.horizontal, 15)
            } // ScrollView
            
            Spacer()
            
            HStack {
                Text("by Fernando Monroy")
                    .foregroundColor(Color(hex: 0x5d4523))
                    .opacity(0.5)
                
                Spacer()
                
                Text("A01750536")
                    .foregroundColor(Color(hex: 0x5d4523))
                    .opacity(0.5)
            }
            .padding(.horizontal)
            
        } // VStack for background color
        .padding()
        .background(Color(hex: 0xECDFCC))
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
        }
        .alert(errorText, isPresented: $showError) {
            Button("OK") {}
        }
    }
}

#Preview {
    ContentView()
}
