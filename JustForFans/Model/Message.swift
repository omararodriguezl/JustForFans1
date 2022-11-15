//
//  Message.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//
import FirebaseFirestoreSwift
import Firebase

struct Message: Identifiable, Decodable {
    let id: String
    let fromId: String
    let toId: String
    let timestamp: Timestamp
    let text: String
    var user: User?
    var read: Bool
    var imageUrl: String?
}

struct ChannelMessage: Identifiable, Decodable {
    @DocumentID var id: String?
    let fromId: String
    let timestamp: Timestamp
    let text: String
    var user: User?
}

