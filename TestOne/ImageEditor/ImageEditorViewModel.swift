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
    
    func cancelImageEditing() {
        imageData = Data(count: 0)
        canvas = PKCanvasView()
    }
    
}
