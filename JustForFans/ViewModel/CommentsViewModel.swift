//
//  CommentsViewModel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/26/22.
//

import SwiftUI
import Firebase

class  CommentsViewModel: ObservableObject {
    private let post: Post
    @Published var comments = [Comment]()
    init (post: Post){
        self.post = post
        fetchComment()
    }
   
    func uploadComment(commentText: String){
        guard let user = AuthViewModel.shared.currentUser else {return}
        guard let postId = post.id else {return}
        let data: [String: Any] = ["username": user.username,
                    "profileImageUrl": user.profileImageUrl,
                    "uid": user.id ?? "",
                    "timestamp": Timestamp(date: Date()),
                    "postOwnerUid":post.ownerUid,
                    "commentText": commentText]
        
        COLLECTION_POSTS.document(postId).collection("post-comments").addDocument(data: data){ error in
            if let error = error {
                print("DEBUG: Error uploading comment \(error.localizedDescription)")
                return
            }
            NotificationViewModel.uploadNotification(toUid: self.post.ownerUid, type: .comment, post: self.post)
        }
    }
    func fetchComment (){
        guard let postId = post.id else {return}
        let query = COLLECTION_POSTS.document(postId).collection("post-comments").order(by: "timestamp" , descending: true)
        query.addSnapshotListener{ shapshot , _ in
            guard let addedDocs = shapshot?.documentChanges.filter({ $0.type == .added}) else {return}
            self.comments.append(contentsOf: addedDocs.compactMap({ try? $0.document.data(as: Comment.self)}))
            
//            shapshot?.documentChanges.forEach({ change in
//                if change.type == .added {
//                    guard let comment = try? change.document.data(as: Comment.self) else {return}
//                    self.comments.append(comment)
//                }
//
//            })
        }
    }
}
