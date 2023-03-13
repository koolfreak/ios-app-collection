//
//  DrawingScreen.swift
//  TestOne
//
//  Created by Emmanuel Nollase on 3/12/23.
//
import PencilKit
import SwiftUI


struct DrawingScreen: View {
    
    @EnvironmentObject var model: ImageEditorViewModel
    
    var body: some View {
        ZStack {
            
            GeometryReader { proxy in
                let size = proxy.frame(in: .global).size
                AnyView(
                    CanvasView(canvas: $model.canvas, imageData: $model.imageData, toolPicker: $model.toolPicker, rect: size)
                )
            }
            
        }
        /*Image(uiImage: ImageFile)
            .resizable()
            .aspectRatio(contentMode: .fit)*/
        
    }
    
}


struct CanvasView: UIViewRepresentable {
    
    @Binding var canvas: PKCanvasView
    @Binding var imageData: Data
    @Binding var toolPicker: PKToolPicker
    
    var rect: CGSize
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        
        if let image = UIImage(data: imageData) {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)
            
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
            
        }
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        //
        
    }
    
    // TODO: undo/redo controls - https://stackoverflow.com/questions/60592875/implement-pencilkit-undo-functionality-using-swiftui
    // https://www.hackingwithswift.com/forums/swiftui/pencilkit-with-swiftui/59
}
