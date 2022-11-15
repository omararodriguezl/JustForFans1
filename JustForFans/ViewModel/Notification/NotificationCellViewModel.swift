//
//  NotificationCellViewModel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/27/22.
//

import Foundation

class NotificationCellViewModel: ObservableObject {
    @Published var notification: Notification
    
    init (notification: Notification){
        self.notification = notification
        checkIfUserIsFollowed()
        fetchNotificationPost()
        fetchNotificationUser()
    }
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? ""
    }
    func follow (){

        UserService.follow(uid: notification.uid ) { _ in
            NotificationViewModel.uploadNotification(toUid: self.notification.uid, type: .follow)
            self.notification.isFollowed = true
        }
    }
    func unfollow(){

        UserService.unfollow(uid: notification.uid){_ in
            self.notification.isFollowed = false
        }
    }
    func checkIfUserIsFollowed(){
        guard notification.type == .follow else {return}
        UserService.checkIfUserIsFollowed(uid: notification.uid){ isFollowed in
            self.notification.isFollowed = isFollowed
            
        }
    }
    func fetchNotificationPost(){
        guard let postId = notification.postId else {return}
        COLLECTION_POSTS.document(postId).getDocument{ shapshot , _ in
            self.notification.post = try? shapshot?.data(as: Post.self)
        }
    }
    func fetchNotificationUser(){
        COLLECTION_USERS.document(notification.uid).getDocument{ shapshot, _ in
            self.notification.user = try? shapshot?.data(as: User.self)
            print("DEBUG: User is \(self.notification.user?.username)")
        }
    }
}
