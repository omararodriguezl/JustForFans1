//
//  CommentsView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/20/22.
//

import SwiftUI

struct CommentsView: View {
    @State var commmentText = ""
    @ObservedObject var viewModel: CommentsViewModel
    init (post: Post){
        self.viewModel = CommentsViewModel(post: post)
    }
    var body: some View {
        VStack{
            //Comment cells
            ScrollView{
                LazyVStack(alignment: .leading){
                    ForEach(viewModel.comments){ comment in
                        CommentsCell(comment: comment)
                            .padding()
                    }
                    
                }
            }
            CustomInputView(inputText: $commmentText, placeholder: "Comment...",action: uploadComment)
        }
        
       
    }
    func uploadComment (){
        viewModel.uploadComment(commentText: commmentText)
        commmentText = ""
    }
}
