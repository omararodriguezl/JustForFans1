//
//  ContentView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/20/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedIndex = 0
    var body: some View {
        Group {
            // if not logged in show login
            // else show main interface
            if viewModel.userSession == nil {
                LogInView()
            }else {
                if let user = viewModel.currentUser {
                    MainTabView(user : user, selectedIndex: $selectedIndex)
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
