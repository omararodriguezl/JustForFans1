//
//  PostGridView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/21/22.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    let config: PostGridConfiguration
    @ObservedObject var viewModel : PostGridViewModel
    
    init (config: PostGridConfiguration){
        self.config = config
        self.viewModel = PostGridViewModel(config: config)
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 2, content: {
            ForEach(viewModel.posts){ post in
                NavigationLink(
                    destination: FeedCell(viewModel: FeedCellViewModel(post: post)), label: {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipped()
                    }).onAppear{
                        guard let index = viewModel.posts.firstIndex(where: {$0.id == post.id})
                        else {return}
                        if case.explore = config , index == viewModel.posts.count - 1{
                            viewModel.fetchExplorePagePost()
                        }
                    }
                
            }
           
        })
    }
}
