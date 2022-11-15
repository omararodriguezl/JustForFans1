//
//  ProfileViewModel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/23/22.
//

import SwiftUI
 
class ProfileViewModel : ObservableObject {
   @Published var user: User
    
    init (user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    func follow (){
        guard let uid = user.id else {return}
        UserService.follow(uid: uid ) { _ in
            NotificationViewModel.uploadNotification(toUid: uid, type: .follow)
            self.user.isFollowed = true
        }
    }
    func unfollow(){
        guard let uid = user.id else {return}
        UserService.unfollow(uid: uid){_ in
            self.user.isFollowed = false
        }
    }
    func checkIfUserIsFollowed(){
        guard !user.isCurrentUser else {return}
        guard let uid = user.id else {return}
        UserService.checkIfUserIsFollowed(uid: uid){ isFollowed in
            self.user.isFollowed = isFollowed
            
        }
    }
    func fetchUserStats(){
        guard let uid = user.id else {return}
        COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments{shapshot,  _ in
            guard let following = shapshot?.documents.count else {return}
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments{ shapshot, _ in
                guard let followers = shapshot?.documents.count else {return}
                
                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments{ shapshot, _ in
                    guard let posts = shapshot?.documents.count else {return}
                    self.user.stats = UserStats(following: following, posts: posts, followers: followers)
                }
            }
        }
    }
}
