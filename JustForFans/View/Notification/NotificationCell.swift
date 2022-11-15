//
//  NotificationCell.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/21/22.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    @ObservedObject var viewModel: NotificationCellViewModel
    var isFollowed: Bool{return viewModel.notification.isFollowed ?? false}
    
    init (viewModel: NotificationCellViewModel){
        self.viewModel = viewModel
    }
    
    @State private var showPostImage = true
    var body: some View {
        HStack {
            if let user = viewModel.notification.user {
                NavigationLink(destination: ProfileView(user: user)){
                    KFImage(URL(string: viewModel.notification.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .clipped()
                        .clipShape(Circle())
                    Text(viewModel.notification.username).foregroundColor(.primary).font(.system(size: 14, weight: .semibold)) + Text (viewModel.notification.type.notificationMessage).foregroundColor(.secondary).font(.system(size: 15))+Text(" \(viewModel.timestampString)").foregroundColor(.secondary).font(.system(size: 12))
                        
                }
            }
            Spacer()
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post {
                    NavigationLink(destination: FeedCell(viewModel: FeedCellViewModel(post: post))){
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                    }
                    
                }
            }else {
                Button(action: {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                }, label: {
                    Text(isFollowed ? "Suscribed" : "Suscribe")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 100, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? Color.white: Color.red)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth:
                                            isFollowed ? 1 : 0)
                        )
                })
            }
        }.padding(.horizontal)
    }
}



