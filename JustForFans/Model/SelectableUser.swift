//
//  SelectableUser.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import Foundation

struct SelectableUser: Identifiable {
    var user: User
    var isSelected: Bool
    
    var id: String { return user.id ?? NSUUID().uuidString }
}
