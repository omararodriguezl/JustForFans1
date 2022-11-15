//
//  NewMessageViewModel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import SwiftUI

enum NewMessageConfiguration {
    case chat
    case group
}

class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var selectableUsers = [SelectableUser]()
    @Published var selectedUsers = [SelectableUser]()
    
    init(config: NewMessageConfiguration) {
        fetchUsers(forConfig: config)
    }
    
    func fetchUsers(forConfig config: NewMessageConfiguration) {
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        
        COLLECTION_USERS.whereField("uid", isNotEqualTo: uid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let users = documents.compactMap({ try? $0.data(as: User.self) })
            
            if config == .chat {
                self.users = users
            } else {
                self.selectableUsers = users.map({ SelectableUser(user: $0, isSelected: false) })
            }
            
        }
    }
    
    func selectUser(_ user: SelectableUser, isSelected: Bool) {
        guard let index = selectableUsers.firstIndex(where: { $0.id == user.id }) else { return }
        
        selectableUsers[index].isSelected = isSelected

        if isSelected {
            selectedUsers.append(selectableUsers[index])
        } else {
            selectedUsers.removeAll(where: { $0.id == user.user.id })
        }
        
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({ $0.fullName.lowercased().contains(lowercasedQuery) || $0.username.contains(lowercasedQuery) })
    }
}
