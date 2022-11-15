//
//  FeedCell.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/20/22.
//

import SwiftUI
import Kingfisher
import AVKit

struct FeedCell: View {
    @ObservedObject var viewModel : FeedCellViewModel
    var didLikes : Bool {return viewModel.post.didLikes ?? false}
    init (viewModel: FeedCellViewModel){
        self.viewModel = viewModel
    }
   
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                KFImage(URL(string: viewModel.post.ownerImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                Text(viewModel.post.ownerUsername)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding([.leading, .bottom] , 8)
            // post Image
            NavigationLink(destination: FeedImageBig(viewModel: viewModel)){
                
                if viewModel.post.fileType == 1 {
                   VideoPlayer(player: AVPlayer(url: URL(string: viewModel.post.imageUrl )!))
                       .scaledToFit()
                       .frame(minWidth: UIScreen.main.bounds.width, maxHeight: 300)
                       .clipped()
              
                }else if viewModel.post.fileType == 0 {
                   
                   KFImage(URL(string: viewModel.post.imageUrl))
                       .resizable()
                       .scaledToFit()
                       .frame(minWidth: UIScreen.main.bounds.width, maxHeight: 300)
                       .clipped()
               }
//                if let image =  KFImage(URL(string: viewModel.post.imageUrl)) {
//                    image
//                        .resizable()
//                        .scaledToFit()
//                        .frame(minWidth: UIScreen.main.bounds.width, maxHeight: 300)
//                        .clipped()
//                } else if  let video = VideoPlayer(player: AVPlayer(url: URL(string: viewModel.post.imageUrl )!)){
//                    video
//                        .scaledToFit()
//                        .frame(minWidth: UIScreen.main.bounds.width, maxHeight: 300)
//                        .clipped()
//                }
                
                
            }
            
            //Action Buttons
            HStack (spacing: 16){
                Button(action: {
                    didLikes ? viewModel.unlike() : viewModel.like()
                }, label: {
                    Image(systemName: didLikes ?  "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(didLikes ? .red: Color("AdaptiveBlack"))
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                })
                NavigationLink(destination: CommentsView(post: viewModel.post) ){
                        Image(systemName: "bubble.right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .font(.system(size: 20))
                            .foregroundColor(Color("AdaptiveBlack"))
                            .padding(4)
                
                }
            }
            .padding(.leading , 4)
            .foregroundColor(.black)
            // Caption
            Text(viewModel.likeString)
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom , 2)
            HStack {
                Text(viewModel.post.ownerUsername).font(.system(size: 14, weight: .semibold)) + Text ("  \(viewModel.post.caption)").font(.system(size: 15))
                
            }.padding(.horizontal, 8)
            Text(viewModel.timestampString)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading, 8)
                .padding(.top , 2)
            
        }
    }
}


