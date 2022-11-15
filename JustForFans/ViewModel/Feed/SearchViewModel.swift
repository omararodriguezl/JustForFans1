//
//  SearchViewModel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/23/22.
//

import SwiftUI
import Firebase

enum SearchViewModelConfig {
    case followers(String)
    case following(String)
    case likes(String)
    case search
    case newMessage
}
class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    private let config: SearchViewModelConfig
    
    init (config: SearchViewModelConfig){
        self.config = config
        fetchUsers(forConfig: config)
    }
    
    func fetchUsers (){
        COLLECTION_USERS.getDocuments{ shapshot, _ in
            guard let documents = shapshot?.documents else {return}
            self.users = documents.compactMap({try? $0.data(as: User.self)})
           // documents.forEach{ shapshot  in
           //     guard let user = try? shapshot.data(as: User.self) else {return}
           //     self.users.append(user)
           // }
        }
    }
    func fetchUsers(forConfig config: SearchViewModelConfig) {
        switch config {
        case .followers(let uid):
            fetchFollowerUsers(forUid: uid)
        case .following(let uid):
            fetchFollowingUsers(forUid: uid)
        case .likes(let postId):
            fetchPostLikesUsers(forPostId: postId)
        case .search, .newMessage:
            fetchUsers()
        }
    }
    private func fetchPostLikesUsers(forPostId postId: String) {
        COLLECTION_POSTS.document(postId).collection("post-likes").getDocuments { snapshot, _ in
            self.fetchUsers(snapshot)
        }
    }
    private func fetchFollowerUsers(forUid uid: String) {
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            self.fetchUsers(snapshot)
        }
    }
    private func fetchFollowingUsers(forUid uid: String) {
        COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _users in
            self.fetchUsers(snapshot)
        }
    }
    private func fetchUsers(_ snapshot: QuerySnapshot?) {
        guard let documents = snapshot?.documents else { return }
        
        documents.forEach { doc in
            UserService.fetchUser(withUid: doc.documentID) { user in
                self.users.append(user)
            }
        }
    }
    func filteredUsers(_ query: String) -> [User]{
        let lowercasedQuery = query.lowercased()
        return users.filter( { $0.fullName.lowercased().contains(lowercasedQuery) ||
            $0.username.lowercased().contains(lowercasedQuery) })
    }
}
