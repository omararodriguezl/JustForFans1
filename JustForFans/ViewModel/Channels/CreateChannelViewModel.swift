//
//  CreateChannelViewModel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import UIKit

class CreateChannelViewModel: ObservableObject {
    let users: [User]
    @Published var didCrateChannel = false
    
    init(users: [User]) {
        self.users = users
    }
    
    func createChannel(name: String, image: UIImage?) {
        guard let currentUser = AuthViewModel.shared.currentUser else { return }
        guard let currentUid = currentUser.id else { return }
        
        var uids = users.map({ $0.id ?? NSUUID().uuidString })
        uids.append(currentUid)
        
        var data: [String: Any] = ["name": name,
                                   "uids": uids,
                                   "lastMessage": "\(currentUser.fullName) created a channel"]
        
        if let image = image {
            ImageUploader.uploadImage(image: image, type: .channel) { imageUrl in
                data["imageUrl"] = imageUrl
                
                COLLECTION_CHANNELS.document().setData(data) { _ in
                    self.didCrateChannel = true
                }
            }
        } else {
            COLLECTION_CHANNELS.document().setData(data) { _ in
                self.didCrateChannel = true
            }
        }
    }
}
