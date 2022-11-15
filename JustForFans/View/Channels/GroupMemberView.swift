//
//  GroupMemberView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import SwiftUI
import Kingfisher

struct GroupMemberView: View {
    @ObservedObject var viewModel: NewMessageViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 8) {
                ForEach(viewModel.selectedUsers) { user in
                    ZStack(alignment: .topTrailing) {
                        VStack {
                            KFImage(URL(string: user.user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipped()
                                .cornerRadius(60 / 2)
                                .shadow(color: .gray, radius: 4, x: 0, y: 2)
                            
                            Text(user.user.fullName)
                                .font(.system(size: 11, weight: .semibold))
                                .multilineTextAlignment(.center)
                        }.frame(width: 64)
                        
                        Button(action: { viewModel.selectUser(user, isSelected: false) }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .padding(6)
                        })
                        .background(Color(.gray))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                    }
                }
            }
        }
        .animation(.spring())
        .padding()
    }
}
