//
//  User.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/23/22.
//

import FirebaseFirestoreSwift

struct User : Identifiable, Decodable {
    @DocumentID var id : String?
    let username : String
    let email: String
    let profileImageUrl : String
    let fullName : String
    var isFollowed : Bool? = false
    var isCurrentUser: Bool {return AuthViewModel.shared.userSession?.uid == id}
    var stats: UserStats?
    var bio: String?
}
struct UserStats: Decodable {
    var following: Int
    var posts: Int
    var followers: Int
}
