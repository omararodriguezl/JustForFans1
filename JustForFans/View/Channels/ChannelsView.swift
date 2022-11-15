//
//  ChannelsView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import SwiftUI

struct ChannelsView: View {
    @State var showNewGroupView = false
    @State var showChat = false
    @State var users = [SelectableUser]()
    @ObservedObject var viewModel = ChannelsViewModel()

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if !users.isEmpty {
                NavigationLink(destination: Text("Group chat"),
                               isActive: $showChat,
                               label: {} )
            }
            
            ScrollView {
                VStack {
                    ForEach(viewModel.channels) { channel in
                        NavigationLink(
                            destination:
                                LazyView(ChannelChatView(channel: channel))
                                .onDisappear(perform: {
                                    viewModel.fetchChannels()
                                }),
                            label: {
                                ChannelCell(channel: channel)
                            })
                    }
                }.padding()
            }.onAppear{
                viewModel.fetchChannels()
            }
            
            HStack {
                Spacer()
                FloatingButton(show: $showNewGroupView)
                    .sheet(isPresented: $showNewGroupView, content: {
                        SelectGroupMembersView(show: $showNewGroupView,
                                               startChat: $showChat,
                                               users: $users)
                    })
            }
            .navigationTitle("Groups")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChannelsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsView()
    }
}
