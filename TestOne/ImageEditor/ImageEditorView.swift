//
//  ImageEditorView.swift
//  TestOne
//
//  Created by Emmanuel Nollase on 3/11/23.
//
import UIKit
import SwiftUI

struct ImageEditorView: View {
    var body: some View {
        
        PhotoEditorView()
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var showPicker: Bool
    @Binding var imageData: Data
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            if let imageData = (info[.originalImage] as? UIImage)?.pngData() {
                
                parent.imageData = imageData
                parent.showPicker.toggle()
                
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            parent.showPicker.toggle()
        }
    }
    
}
