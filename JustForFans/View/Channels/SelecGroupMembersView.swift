//
//  SelecGroupMembersView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import SwiftUI
import Kingfisher

struct SelectGroupMembersView: View {
    @State var searchText = ""
    @Binding var show: Bool
    @Binding var startChat: Bool
    @Binding var users: [SelectableUser]
    @ObservedObject var viewModel = NewMessageViewModel(config: .group)
    
    var body: some View {
        NavigationView {
            VStack {
                
                SeachBar(text: $searchText, isEditing: .constant(false))
                    .padding()
                
                if !viewModel.selectedUsers.isEmpty {
                    GroupMemberView(viewModel: viewModel)
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.selectableUsers) { user in
                            HStack { Spacer() }
                            
                            Button(action: {
                                viewModel.selectUser(user, isSelected: !user.isSelected)
                            }, label: {
                                SelectableUserCell(selectableUser: user)
                            })
                        }
                    }.padding(.leading)
                }
            }
            .navigationBarItems(leading: cancelButton, trailing: nextButton)
            .navigationTitle("New Group")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var nextButton: some View {
        NavigationLink(destination: CreateChannelView(users: viewModel.selectedUsers.map({ $0.user }), show: $show)) {
            Text("Next").bold()
        }
    }
    
    var cancelButton: some View {
        Button { show.toggle() } label: {
            Text("Cancel")
        }
    }
}
