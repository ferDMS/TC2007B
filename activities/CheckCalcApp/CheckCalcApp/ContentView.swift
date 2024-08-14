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

struct ContentView: View {
    
    // Variables to obtain input
    @State private var spendingInput : String = ""
    @State private var groupSizeInput : String = ""
    @State private var tipPercentageInput : String = ""
    @State private var isFreeForOne : Bool = false
    let defaultTip = 10.0
    
    // For picker wheel options
    let groupSizes : [String] = [""] + Array(1...20).map{ String($0) }
    
    // Final result variables
    @State private var showResult : Bool = false
    @State private var spentPerPersonOutput : String = ""
    
    func isValidInput() -> Bool {
        let isTotalCostValid = Double(spendingInput) != nil
        let isGroupSizeValid = !groupSizeInput.isEmpty
        let isTipPercentageValid = tipPercentageInput.isEmpty || Double(tipPercentageInput) != nil

        return isTotalCostValid && isGroupSizeValid && isTipPercentageValid
    }
    
    func calcResult() {
        let spending = Double(spendingInput)!
        var groupSize = Double(groupSizeInput)!
        let tipPercentage = tipPercentageInput.isEmpty ? defaultTip : Double(tipPercentageInput)!
        
        if isFreeForOne {
            groupSize -= 1
        }
        
        let spentPerPerson = (spending + spending * (tipPercentage/100)) / groupSize
        
        // Pay more than calculated with non-terminating calculations
        let roundedValue = ceil(spentPerPerson * 100) / 100
        
        spentPerPersonOutput = String(format: "%.2f", roundedValue)
        showResult = true
    }

    var body: some View {
        
        // VStack for background color
        VStack (alignment: .leading) {
            
            Text("Restaurant Check Calculator 🍔🧮")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: 0x1E201E))
            
            ScrollView {
                
                if showResult {
                    
                    VStack (alignment: .center) {
                        Text("To pay per person:")
                            .font(.system(size: 30)) // Custom size

                        Text("$\(spentPerPersonOutput)")
                            .font(.system(size: 40, weight: .bold))
                        
                    }
                    .padding()
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
                                    .keyboardType(.numberPad)
                                    .fontWeight(.bold)
                                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 10)) // Add leading padding to shift text right
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(hex: 0xf3ece0))
                                            .stroke(.black, lineWidth: 2)
                                        
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
                                    .stroke(.black, lineWidth: 2)
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
                                    .keyboardType(.numberPad)
                                    .fontWeight(.bold)
                                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 10)) // Add leading padding to shift text right
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(hex: 0xf3ece0))
                                            .stroke(.black, lineWidth: 2)
                                        
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
                        
                        Toggle("", isOn: $isFreeForOne)
                            .tint(Color(hex: 0x1E201E))
                            .onChange(of: isFreeForOne) {
                            oldValue, newValue in
                        }
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            if isValidInput() {
                                calcResult()
                            }
                        }) {
                            Text("Calculate")
                                .font(.title)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color(hex: 0xdcc5a2))
                        .foregroundColor(.black)
                        .padding(.top, 25)
                        
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
    }
}

#Preview {
    ContentView()
}
