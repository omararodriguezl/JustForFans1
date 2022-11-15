//
//  ProfileActionButtonView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/21/22.
//

import SwiftUI

struct ProfileActionButtonView: View {
    @ObservedObject var viewModel: ProfileViewModel
    var isFollowed: Bool {return viewModel.user.isFollowed ?? false}
    @State var showEditProfile = false
    
    var body: some View {
        if viewModel.user.isCurrentUser {
            Button (action:{
                showEditProfile.toggle()
            }, label: {
                Text("Edit Profile")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 360, height: 32)
                    .foregroundColor(Color("AdaptiveBlack"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }).sheet(isPresented: $showEditProfile) {
                EditProfileView(user: $viewModel.user)
            }
        }else {
            HStack {
                Button (action:{ isFollowed ? viewModel.unfollow(): viewModel.follow()
                }, label: {
                    Text(isFollowed ? "Suscribed" : "Suscribe")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? Color.white: Color.red)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth:
                                            isFollowed ? 1 : 0)
                        )
                }).cornerRadius(3)
                NavigationLink(destination: ChatView(user: viewModel.user)){
                    Text("Message")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
        }
    }
}


