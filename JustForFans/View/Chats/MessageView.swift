//
//  MessageView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import SwiftUI
import Kingfisher

struct MessageView: View {
    let viewModel: MessageViewModel
    
    var body: some View {
        HStack {
            if viewModel.isFromCurrentUser {
                Spacer()
                
                if viewModel.isImageMessage {
                    KFImage(viewModel.messageImageUrl)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.5, maxHeight: 800)
                        .cornerRadius(10)
                        .padding(.trailing)
                } else {
                    Text(viewModel.message.text)
                        .padding(12)
                        .background(Color.blue)
                        .clipShape(ChatBubble(isFromCurrentUser: true))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.leading, 100)
                        .font(.system(size: 15))
                }
            } else {
                HStack(alignment: .bottom) {
                    
                    KFImage(viewModel.profileImageUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    
                    if viewModel.isImageMessage {
                        KFImage(viewModel.messageImageUrl)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.5, maxHeight: 800)
                            .cornerRadius(10)
                    } else {
                        Text(viewModel.message.text)
                            .padding(12)
                            .background(Color(.systemGray5))
                            .font(.system(size: 15))
                            .clipShape(ChatBubble(isFromCurrentUser: false))
                            .foregroundColor(Color("AdaptiveBlack"))
                    }
                    
                }
                .padding(.horizontal)
                .padding(.trailing, 80)
                
                Spacer()
            }
        }
    }
}
