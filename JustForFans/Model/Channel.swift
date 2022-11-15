//
//  Channel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import FirebaseFirestoreSwift

struct Channel: Identifiable, Decodable {
    @DocumentID var id: String?
    var name: String
    var imageUrl: String?
    var uids: [String]
    var lastMessage: String
}
