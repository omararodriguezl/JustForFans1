//
//  JustForFansApp.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/20/22.
//

import SwiftUI
import Firebase

@main
struct JustForFansApp: App {
    init (){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
            //LogInView()
        }
    }
}
