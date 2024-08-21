//
//  DetalleView.swift
//  PasoValores
//
//  Created by PEZ on 20/08/24.
//

import SwiftUI

struct DetalleView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State public var nameReadOnlyChild = "default"
    
    // Binding variable for second way of communicating data between views
    // This variable will always hold the value of the original
    // Must always be binded to a variable ("defined") when instatiating the view
    @Binding public var ageBindedChild : String
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            HStack{Spacer()}
            
            Spacer()
            
            Text("Welcome, \(nameReadOnlyChild)")
                .font(.largeTitle)
                .foregroundStyle(.black)
                .bold()
                .padding(.bottom)

            Text("Edit Age")
                .font(.title2)
                .foregroundStyle(.black)
                .bold()
            
            // Binding to a binding, cool :)
            TextField("20", text:$ageBindedChild)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            
            // Can't go back if field is empty
            Button("Go back") {
                if (ageBindedChild != "") {
                    // This makes us go back without the top-left corner button
                    dismiss() // Works for iOS +15
                }
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .background(
            Color(red: 236/255.0, green: 223/255.0, blue: 204/255.0)
        )
        .toolbar(.hidden)
    }
}

#Preview {
    // Container to hold initialization of the preview view
    ZStack {
        @State var defaultAgeBinding : String = ""
        // Must define the binding, even for the preview
        DetalleView(ageBindedChild: $defaultAgeBinding)
    }
    
}
