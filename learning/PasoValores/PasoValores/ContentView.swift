//
//  ContentView.swift
//  PasoValores
//
//  Created by PEZ on 20/08/24.
//

import SwiftUI

struct ContentView: View {
    
    // To be edited as a TextField
    @State private var nameReadOnly : String = ""
    
    @State private var ageBinded : String = ""
    
    var body: some View {
        
        // NavigationStack to add the child view
        NavigationStack {
            
            VStack (alignment: .leading){
                
                // To make the VStack expand to 100% horizontally
                // This way the background is correctly placed
                HStack{Spacer()}
                
                Spacer()
                
                Text("Registration form 📋")
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                    .bold()
                    .padding(.bottom)
                
                Text("Full name")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .bold()
                
                
                TextField("Joe Doe", text:$nameReadOnly)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                Text("Age")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .bold()
                
                Text("You can change this later :)")
                    .font(.body)
                    .foregroundStyle(.black)
                
                // This is another example of a binding
                // Where the variable `ageBinded` will always hold whatever is the input in the TextField
                TextField("20", text:$ageBinded)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                NavigationLink("Go to child view") {
                    
                    // Way to pass data number 1 (like read-only)
                    // Any changes made to `name` inside the child view
                    // will not reflect into the parent view
                    
                    // Way to pass data number 2 (binding)
                    // Through the `$` we pass a <Binding> object of the specified variable. This type of wrapper is similar to the <Optional> wrapper in this sense.
                    
                    DetalleView(
                        nameReadOnlyChild: nameReadOnly,
                        ageBindedChild: $ageBinded
                    )
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
            .background(
                Color(red: 236/255.0, green: 223/255.0, blue: 204/255.0)
            )
        }
        .navigationBarTitle("Volver")
    }
}

#Preview {
    ContentView()
}
