//
//  ProfileHeaderView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/21/22.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading, 8)
                Spacer()
                HStack  (spacing: 24) {
                    UserStatView(value: viewModel.user.stats?.posts ?? 0, title: "Post")
                    
                    NavigationLink (destination: UserListView(viewModel: SearchViewModel(config: .followers(viewModel.user.id ?? "")), searchText: .constant(""))){
                        UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Suscribers")
                    }
                    NavigationLink (destination: UserListView(viewModel: SearchViewModel(config: .following(viewModel.user.id ?? "")), searchText: .constant(""))){
                        UserStatView(value: viewModel.user.stats?.following ?? 0, title: "Subscriptions")
                    }
                    
                }.padding(.trailing, 32)
            }
            Text (viewModel.user.fullName)
                .font(.system(size: 15 , weight: .semibold))
                .padding([.leading , .top])
            if let bio = viewModel.user.bio {
                Text (bio)
                    .font(.system(size: 15))
                    .padding(.leading)
                    .padding(.top , 1)
            }
            HStack {
                Spacer()
                ProfileActionButtonView(viewModel: viewModel)
                Spacer()
            }.padding(.top)
           
        }
    }
}

