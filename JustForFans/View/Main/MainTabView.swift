//
//  MainTabView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/20/22.
//

import SwiftUI

struct MainTabView: View {
    let user : User
    @Binding var selectedIndex : Int
    var body: some View {
        NavigationView{
            TabView (selection: $selectedIndex){
                FeedView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "house")
                    }.tag(0)
                
                SeachView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }.tag(1)
                
                UploadPostView(tabIndex: $selectedIndex)
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "plus.square")
                    }.tag(2)
                
                NotificationView()
                    .onTapGesture {
                        selectedIndex = 3
                    }
                    .tabItem {
                        Image(systemName: "heart")
                    }.tag(3)
                
                ProfileView(user : user)
                    .onTapGesture {
                        selectedIndex = 4
                    }
                    .tabItem {
                        Image(systemName: "person")
                    }.tag(4)
            }
            .navigationTitle(tabTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: selectedIndex == 0 ? longoutButton : nil,
                                trailing: selectedIndex == 0 ? messageLink : nil)
            .accentColor(Color("AdaptiveBlack"))
            
        }
        
    }
    var longoutButton : some View {
        Button {
            AuthViewModel.shared.signOut()
        }label: {
            Text("LogOut").foregroundColor(Color("AdaptiveBlack"))
        }
    }
    var messageLink: some View {
        NavigationLink(
            destination: ConversationsView(),
            label: {
                Image(systemName: "paperplane")
                    .resizable()
                    .font(.system(size: 20, weight: .light))
                    .scaledToFit()
                    .foregroundColor(Color("AdaptiveBlack"))
            })
    }
    
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Feed"
        case 1: return "Explore"
        case 2: return "New Post"
        case 3: return "Notification"
        case 4: return "Profile"
        default : return ""
            
        }
    }
}
