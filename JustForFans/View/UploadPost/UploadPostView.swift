//
//  UploadPostView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/20/22.
//

import SwiftUI
import AVKit

struct UploadPostView: View {
    @State private var selectedImage: UIImage?
    @State var postImage: Image?
    @State var urlVideo: String?
    @State var captionText = ""
    @State var imagePickerPresented = false
    @Binding var tabIndex: Int
    @ObservedObject var viewModel = UploadPostViewModel ()
    var body: some View {
        VStack {
//            if let url = urlVideo{
//                HStack (alignment: .top ){
//                    VideoPlayer(player: AVPlayer(url: URL(string: "\(url)" )!))
//                        .scaledToFit()
//                        .frame(width: 96, height: 96)
//                        .clipped()
//                    TextArea(text: $captionText, placeholder: "Enter your caption..")
//                        .frame(height: 200)
//                }.padding()
//
//                    HStack (spacing: 16){
//                        Button(action: {
//                            captionText = ""
//                            postImage = nil
//
//                        }, label: {
//                            Text("Cancel")
//                                .font(.system(size: 16, weight: .semibold))
//                                .frame(width: 172, height: 50)
//                                .background(Color.red)
//                                .cornerRadius(5)
//                                .foregroundColor(.white)
//                        }).padding()
//                        Button(action: {
//                            viewModel.uploadPostVideo(caption: captionText, url: url){_ in
//                                    captionText = ""
//                                    postImage = nil
//                                    tabIndex = 0
//                                }
//
//                        }, label: {
//                            Text("Share")
//                                .font(.system(size: 16, weight: .semibold))
//                                .frame(width: 172, height: 50)
//                                .background(Color.blue)
//                                .cornerRadius(5)
//                                .foregroundColor(.white)
//                        }).padding()
//                    }
//
//            }else
            if postImage == nil {
                Button (action: { imagePickerPresented.toggle()}, label: {
                    VStack{
                        Image(systemName: "plus")
                            .font(.title)
                            .padding(.bottom, 4)
                            .foregroundColor(Color("AdaptiveBlack"))
                        Text("Photo")
                            .font(.headline)
                            .foregroundColor(Color("AdaptiveBlack"))
                    }
                })
                    .padding(50)
                    .foregroundColor(.black)
                    .overlay(Circle().stroke(Color("AdaptiveBlack"), lineWidth: 2))
                    .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage , content: {
                        ImagePicker(image: $selectedImage , urlVideo: $urlVideo)
                    })
                   
            }else if let image = postImage{
                    HStack(alignment: .top) {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 96, height: 96)
                            .clipped()
                      //  TextField("Enter your caption.." , text: $captionText)
                        TextArea(text: $captionText, placeholder: "Enter your caption..")
                            .frame(height: 200)
                    }.padding()
                
                HStack (spacing: 16){
                    Button(action: {
                        captionText = ""
                        postImage = nil
                        
                    }, label: {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 172, height: 50)
                            .background(Color.red)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                    }).padding()
                    Button(action: {
                        if let image = selectedImage {
                            viewModel.uploadPost(caption: captionText, image: image){_ in
                                captionText = ""
                                postImage = nil
                                tabIndex = 0
                            }
                        }
                        
                    }, label: {
                        Text("Share")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 172, height: 50)
                            .background(Color.blue)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                    }).padding()
                }
            }
            
            
            Spacer()
        }
        
    }
}
extension UploadPostView {
    func loadImage() {
        guard let selectedImage = selectedImage else {return}
        postImage = Image(uiImage: selectedImage)
    }
  
}

