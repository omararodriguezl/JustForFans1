//
//  CreateChannelView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import SwiftUI

struct CreateChannelView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var channelImage: Image?
    @State private var channelName = ""
    @Binding var show: Bool

    @ObservedObject var viewModel: CreateChannelViewModel
    
    init(users: [User], show: Binding<Bool>) {
        self.viewModel = CreateChannelViewModel(users: users)
        self._show = show
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 32) {
                Button(action: { showImagePicker.toggle() }, label: {
                    if let channelImage = channelImage {
                        channelImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    } else {
                        Image("plus_photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    }
                }).sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                    ImagePicker(image: $selectedImage , urlVideo: .constant(""))
                })
                
                VStack(alignment: .leading, spacing: 12) {
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.separator))
                    
                    TextField("Enter a name for your channel..", text: $channelName)
                        .font(.system(size: 15))
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.separator))
                    
                    Text("Please provide a channel name and icon")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }.padding(.trailing)
                
            }.padding()
            
            Spacer()
        }
        .onReceive(viewModel.$didCrateChannel, perform: { completed in
            if completed {
                show.toggle()
            }
        })
        .navigationBarItems(trailing: createChannelButton)
    }
    
    var createChannelButton: some View {
        Button(action: { viewModel.createChannel(name: channelName, image: selectedImage)}, label: {
            Text("Create").bold()
                .disabled(channelName.isEmpty && channelImage != nil)
        })
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        channelImage = Image(uiImage: selectedImage)
    }
}

