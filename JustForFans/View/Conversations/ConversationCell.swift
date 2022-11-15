//
//  ConversationCell.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import SwiftUI
import Kingfisher

struct ConversationCell: View {
    let viewModel: MessageViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                KFImage(viewModel.profileImageUrl)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .cornerRadius(28)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.fullname)
                        .foregroundColor(Color("AdaptiveBlack"))
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(viewModel.message.text)
                        .foregroundColor(Color("AdaptiveBlack"))
                        .font(.system(size: 15))
                        .lineLimit(2)
                }
                .foregroundColor(.black)
                .padding(.trailing)
                
                Spacer()
            }
            
            Divider()
        }
    }
}
