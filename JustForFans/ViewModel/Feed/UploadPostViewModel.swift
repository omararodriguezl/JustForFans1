//
//  UploadPostViewModel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/24/22.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    
    func uploadPost (caption : String, image: UIImage, completion: FirestoreCompletion){
        guard let user = AuthViewModel.shared.currentUser else {return}
        ImageUploader.uploadImage(image: image, type: .post){ imageUrl in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes" : 0,
                        "ownerUid": user.id ?? "",
                        "imageUrl" : imageUrl,
                        "fileType": 0,
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data , completion: completion)
        }
    }
    func uploadPostVideo (caption : String, url: String, completion: FirestoreCompletion){
        guard let user = AuthViewModel.shared.currentUser else {return}
        ImageUploader.uploadVideo(url: url, type: .post){ imageUrl in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes" : 0,
                        "ownerUid": user.id ?? "",
                        "imageUrl" : imageUrl,
                        "fileType": 1,
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data , completion: completion)
        }
    }
}
