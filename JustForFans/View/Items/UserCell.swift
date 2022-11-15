
//
//  UserCell.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/21/22.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack {
            //Image
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipped()
                .clipShape(Circle())
            //VStack -> Username and full name
            VStack (alignment: .leading){
                Text(user.username)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("AdaptiveBlack"))
                
                Text(user.fullName)
                    .font(.system(size: 14))
                    .foregroundColor(Color("AdaptiveBlack"))
            }
            Spacer()
        }
        
    }
}


