//
//  PHPickerSwiftUI.swift
//  TestC24Sep
//
//  Created by Cristina Gonzalez Cordova on 24/09/24.
//  Referencia:
//  https://mobileappsacademy.medium.com/phpicker-in-swiftui-a56639dcf8f5
//  Ajustado y modificado por: Cristina Gonzalez
//
import SwiftUI
import PhotosUI

struct PHPickerSwiftUI: UIViewControllerRepresentable {
   
    @Binding var selectedImage: UIImage?
    
    @Environment(\.presentationMode) var isPresented
    
    // Configuration for the PHPicker
    private var config: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 20
        config.preferredAssetRepresentationMode = .current
        return config
    }
        
    // Creates the ViewController, so, the object that will take in inputs from the user
    func makeUIViewController(context: Context) ->  PHPickerViewController {
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // No se modifica nada en esta vista
    }
    
    // Create coordinator for the PHPickerViewController (handles interactions)
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // Conforms as a valid ControllerDellegate, which will be our 'Coordinator'
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: PHPickerSwiftUI
        
        init(parent: PHPickerSwiftUI) {
            self.parent = parent
        }
        
        // Called when finishing picking an image
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
                
            if let result = results.first{
                result .itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    if let uiImage = object as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.selectedImage = uiImage
                        }
                    }
                }
            }
                
            // Close window to choose image
            self.parent.isPresented.wrappedValue.dismiss()
        }
    }
    
}
