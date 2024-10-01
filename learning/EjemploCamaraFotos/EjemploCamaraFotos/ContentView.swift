//
//  ContentView.swift
//  EjemploCamaraFotos
//
//  Created by PEZ on 25/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedImage : UIImage?
    @State private var showCamera : Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("Foto y Camera")
                if (selectedImage != nil) {
                    Image(uiImage: selectedImage!)
                        .resizable(resizingMode: .stretch)
                }
                
                Button("Tomar Foto") {
                    showCamera.toggle()
                }
                // By using a `sheet` we are displaying a modal on top of the content
                .sheet(isPresented: $showCamera, content: {
                    CameraPickerView(selectedImage: $selectedImage).ignoresSafeArea()
                }).buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
