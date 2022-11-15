//
//  PostGridViewModel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/25/22.
//

import SwiftUI
import Firebase

enum PostGridConfiguration {
    case explore
    case profile (String)
}

class PostGridViewModel : ObservableObject {
    @Published var posts = [Post]()
    let config: PostGridConfiguration
    private var lastDoc: QueryDocumentSnapshot?
    
    init (config: PostGridConfiguration){
        self.config = config
        fetchPost(forConfig: config)
    }
    func fetchPost (forConfig config: PostGridConfiguration){
        switch config{
        case .explore:
            fetchExplorePagePost()
        case.profile(let uid):
            fetchUserPost(forUid: uid)
        }
    }
    func fetchExplorePagePost(){
        COLLECTION_POSTS.order(by: "likes" , descending: true).getDocuments{ shapshot, _ in
            guard let documents = shapshot?.documents else {return}
            self.posts = documents.compactMap({try? $0.data(as: Post.self)})
        }
    }
    func fetchUserPost(forUid uid: String){
        COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments{ shapshot, _ in
            guard let documents = shapshot?.documents else {return}
            let posts = documents.compactMap({ try? $0.data(as: Post.self)})
            self.posts = posts.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()})
        }
    }
    func fetchExplorePagePosts() {
        let query = COLLECTION_POSTS.limit(to: 15).order(by: "timestamp", descending: true)
        
        if let last = lastDoc {
            let next = query.start(afterDocument: last)
            next.getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents, !documents.isEmpty else { return }
                self.lastDoc = snapshot?.documents.last
                self.posts.append(contentsOf: documents.compactMap({ try? $0.data(as: Post.self) }))
            }
        } else {
            query.getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                self.posts = documents.compactMap({ try? $0.data(as: Post.self) })
                self.lastDoc = snapshot?.documents.last
            }
        }
    }
}
