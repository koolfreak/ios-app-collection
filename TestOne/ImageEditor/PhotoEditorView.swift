//
//  PhotoEditorView.swift
//  TestOne
//
//  Created by Emmanuel Nollase on 3/11/23.
//

import SwiftUI

struct PhotoEditorView: View {
    
    @StateObject var model = ImageEditorViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let ImageFile = UIImage(data: model.imageData){
                    
                    DrawingScreen().environmentObject(model)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading, content: {
                                Button {
                                    model.cancelImageEditing()
                                } label: {
                                    Text("Cancel")
                                }
                            })

                        }
                    
                } else {
                    Button("Pick Image"){
                        model.showImagePicker.toggle()
                    }
                }
                
            }
            .navigationTitle("Image Editor")
        }
        .sheet(isPresented: $model.showImagePicker) {
            ImagePicker(showPicker: $model.showImagePicker, imageData: $model.imageData)
        }
    }
}


