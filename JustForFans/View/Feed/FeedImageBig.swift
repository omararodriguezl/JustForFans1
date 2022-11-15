//
//  FeedImageBig.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 11/1/22.
//

import SwiftUI
import Kingfisher

struct FeedImageBig: View {
    @ObservedObject var viewModel : FeedCellViewModel
    init (viewModel: FeedCellViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack (alignment: .leading){
            // post Image
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .scaledToFit()
                .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                .clipped()
            
            
            
        }.navigationTitle("Image")
    }
}
