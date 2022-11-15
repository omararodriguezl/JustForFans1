//
//  CustomInputConversationView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import SwiftUI

struct CustomInputConversationView: View {
    @Binding var inputText: String
    @Binding var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var image: Image?
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
                .padding(.bottom, 8)
            HStack {
                if let image = image, selectedImage != nil {
                    ZStack(alignment: .topTrailing) {
                        image
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 140, height: 140)
                            .cornerRadius(10)
                        
                        Button(action: {
                            selectedImage = nil
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .padding(8)
                        })
                        .background(Color(.gray))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                    }
                    
                    Spacer()
                } else {
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        Image(systemName: "photo")
                            .foregroundColor(Color("AdaptiveBlack"))
                            .padding(.trailing, 4)
                    }.sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                        ImagePicker(image: $selectedImage, urlVideo: .constant(""))
                    })
                    
                    TextField("Message..", text: $inputText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.body)
                        .frame(minHeight: 30)
                }
                                
                Button(action: action) {
                    Text("Send")
                        .bold()
                        .foregroundColor(Color("AdaptiveBlack"))
                }
            }
            .padding(.bottom, 8)
            .padding(.horizontal)
        }
    }
    
    private func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}
