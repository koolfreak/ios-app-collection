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
        ZStack {
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
            
            //
            if model.addNewBox {
                Color.black.opacity(0.75).ignoresSafeArea()
                // Textfield
                TextField("Type Here", text: $model.textBoxes[model.currentIndex].text)
                    .font(.system(size: 35, weight: model.textBoxes[model.currentIndex].isBold ? .bold : .regular))
                    .colorScheme(.dark)
                    .foregroundColor(model.textBoxes[model.currentIndex].textColor)
                    .padding()
                
                
                HStack {
                    Button(action: {
                        model.textBoxes[model.currentIndex].isAdded = true
                        // closing the view....
                        model.toolPicker.setVisible(true, forFirstResponder: model.canvas)
                        model.canvas.becomeFirstResponder()
                        
                        withAnimation {
                            model.addNewBox = false
                        }
                    }) {
                        Text("Add")
                    }
                    Spacer()
                    Button(action: model.cancelTextView) {
                        Text("Cancel")
                    }
                }
                .overlay(
                    HStack(spacing: 15) {
                        ColorPicker("",selection: $model.textBoxes[model.currentIndex].textColor)
                            .labelsHidden()
                        
                        Button(action: {
                            model.textBoxes[model.currentIndex].isBold.toggle()
                        }) {
                            Text(model.textBoxes[model.currentIndex].isBold ? "Normal": "Bold" )
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                    
                )
                .frame(maxHeight: .infinity, alignment: .top)
            }
            
        }
        .sheet(isPresented: $model.showImagePicker) {
            ImagePicker(showPicker: $model.showImagePicker, imageData: $model.imageData)
        }
        .alert(isPresented: $model.showAlert) {
            Alert(title: Text("Message"), message: Text(model.message), dismissButton: .destructive(Text("Ok")))
        }
    }
}


