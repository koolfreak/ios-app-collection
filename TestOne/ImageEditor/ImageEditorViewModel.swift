//
//  ImageEditorViewModel.swift
//  TestOne
//
//  Created by Emmanuel Nollase on 3/11/23.
//
import SwiftUI
import PencilKit


class ImageEditorViewModel: ObservableObject {
    
    @Published var showImagePicker = true
    @Published var imageData: Data = Data(count: 0)
    
    @Published var canvas = PKCanvasView()
    @Published var toolPicker = PKToolPicker()
    
    @Published var textBoxes: [TextBox] = []
    @Published var addNewBox = false
    
    @Published var currentIndex: Int = 0
    
    @Published var rect: CGRect = .zero
    
    //Alert...
    @Published var showAlert = false
    @Published var message: String = ""
    
    func cancelImageEditing() {
        imageData = Data(count: 0)
        canvas = PKCanvasView()
        textBoxes.removeAll()
    }
    
    func cancelTextView() {
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        withAnimation {
            addNewBox = false
        }
        //
        if !textBoxes[currentIndex].isAdded {
            textBoxes.removeLast()
        }
    }
    
    func saveImage() {
        
        // generating image from both canvas and out textboxes view
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        canvas.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        // adding texboxes...
        let swiftUI = ZStack {
            
            ForEach(textBoxes) { [self] box in
                Text(textBoxes[currentIndex].id == box.id && addNewBox ? "": box.text)
                    .font(.system(size: 30))
                    .fontWeight(box.isBold ? .bold : .none)
                    .foregroundColor(box.textColor)
                    .offset(box.offset)
            }
            
        }
        let controller = UIHostingController(rootView: swiftUI).view!
        controller.frame = rect
        
        // claering bg...
        controller.backgroundColor = .clear
        canvas.backgroundColor = .clear
        
        controller.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        
        // getting image...
        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()
            
        // enidng render...
        // UIGraphicsEndPDFContext()
        UIGraphicsEndImageContext()
        
        if let image = generatedImage?.pngData() {
            // saving image to
            UIImageWriteToSavedPhotosAlbum(UIImage(data: image)!, nil, nil, nil)
            self.message = "Successfully Save!"
            self.showAlert.toggle()
        }
    }
}
