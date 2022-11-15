//
//  AuthViewModel.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/22/22.
//

import SwiftUI
import Firebase

class AuthViewModel : ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var didSendResetPassword = false
    
    static let shared = AuthViewModel()
    init(){
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func longIn(withEmail email:String, password: String ){
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if let error = error {
                print("DEBUG: Login failed \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchUser()
        }
    }
    func register(withEmail email: String, password: String, image: UIImage?, fullName: String, userName: String){
        guard let image = image else {return}
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print (error.localizedDescription)
                    return
                }
                guard let user = result?.user else { return}
                print("SuccessFully registegered user ...")
                
                let data = ["email" : email,
                            "username": userName,
                            "fullName" : fullName,
                            "profileImageUrl": imageUrl,
                            "uid" : user.uid]
                COLLECTION_USERS.document(user.uid).setData(data) { _ in
                    print("SuccessFully uploaded user data...")
                    self.userSession = user
                    self.fetchUser()
                    
                }
            }
        }
    }
    func signOut(){
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    func resetPassword (email : String){
        Auth.auth().sendPasswordReset(withEmail: email){error in
            if let error = error {
                print("Failed to send link with error \(error.localizedDescription)")
                return
            }
            self.didSendResetPassword = true
        }
    }
    func fetchUser(){
        guard let uid = userSession?.uid else {return}
        COLLECTION_USERS.document(uid).getDocument{ shapshot, _ in
        guard  let user = try? shapshot?.data(as: User.self) else {return}
            self.currentUser = user
            print ("DEBUG: user is \(user)")
        }
        
    }
}
