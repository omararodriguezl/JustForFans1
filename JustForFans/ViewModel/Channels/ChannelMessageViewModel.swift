//
//  ChannelMessageViewModel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import Foundation

struct ChannelMessageViewModel {
    let message: ChannelMessage
    
    var currentUid: String { return AuthViewModel.shared.userSession?.uid ?? "" }
    
    var isFromCurrentUser: Bool { return message.fromId == currentUid }
    
    var fullname: String {
        return message.user?.fullName ?? ""
    }
}
