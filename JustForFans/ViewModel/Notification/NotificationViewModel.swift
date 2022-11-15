//
//  NotificationViewModel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/27/22.
//

import SwiftUI
import Firebase

class NotificationViewModel: ObservableObject {
    @Published var notification = [Notification]()
    init (){
        fetchNotification()
    }
    
    func fetchNotification(){
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        let query = COLLECTION_NOTIFICATION.document(uid).collection("user-notification").order(by: "timestamp", descending: true)
        
        query.getDocuments{ shapshot , _ in
            guard let documents = shapshot?.documents else {return}
            self.notification = documents.compactMap({try? $0.data(as: Notification.self)})
            
        }
    }
    static func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil){
        guard let user = AuthViewModel.shared.currentUser else {return}
        guard uid != user.id else {return}
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "username": user.username ,
                                   "uid": user.id ?? "",
                                   "profileImageUrl": user.profileImageUrl,
                                   "type": type.rawValue]
        if let post = post, let id = post.id{
            data["postId"] = id
        }
        COLLECTION_NOTIFICATION.document(uid).collection("user-notification").addDocument(data: data)
        
    }
}
