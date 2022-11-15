//
//  Post.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/24/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable {
    @DocumentID var id : String?
    let caption : String
    var likes : Int
    let ownerUid : String
    let imageUrl : String
    let ownerImageUrl : String
    let ownerUsername : String
    let timestamp : Timestamp
    let fileType: Int?
    var didLikes: Bool? = false
    
}



