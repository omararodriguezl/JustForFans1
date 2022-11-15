//
//  UserService.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/23/22.
//

import Firebase

typealias FirestoreCompletion = ((Error?) -> Void)?

struct UserService {
    static func follow (uid: String, completion: ((Error?) -> Void)? ){
        guard let currentUid = AuthViewModel.shared.userSession?.uid else {return}
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]){ _ in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    static func unfollow (uid: String, completion: ((Error?) -> Void)? ){
        guard let currentUid = AuthViewModel.shared.userSession?.uid else {return}
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete{ _ in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    static func checkIfUserIsFollowed (uid: String, completion: @escaping(Bool) -> Void){
        guard let currentUid = AuthViewModel.shared.userSession?.uid else {return}
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument{ shapshot, _ in
            guard let isFollowed = shapshot?.exists else {return}
            completion(isFollowed)
        }
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
}
