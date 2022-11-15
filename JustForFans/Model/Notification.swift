//
//  Notification.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/27/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Notification : Identifiable, Decodable {
    @DocumentID var id: String?
    var postId: String?
    let username : String
    let profileImageUrl: String
    let type: NotificationType
    let uid: String
    let timestamp: Timestamp
    var isFollowed : Bool? = false
    
    var post : Post?
    var user: User?
}

enum NotificationType: Int, Decodable {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like : return " Liked one of your posts"
        case .comment: return " commented on one of your posts"
        case .follow: return " started following you."
        }
    }
}
