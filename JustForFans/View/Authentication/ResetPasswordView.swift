//
//  ResetPasswordView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/22/22.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment (\.presentationMode) var mode
    @Binding private var email: String
    
    init(email: Binding<String>){
        self._email = email
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors:[Color.red , Color.purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack (spacing: 15){
               Image("JustForFansLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                    .foregroundColor(.white)
                VStack (spacing: 20){
                    // Email Field
                    CustomTextField (text: $email, placeholder: Text ("Email"), imagName: "envelope")
                        .padding()
                        .background(Color (.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal , 32)
                }
                //Sign in
                Button(action: {
                    viewModel.resetPassword(email : email)
                }, label: {
                    Text("Send Reset password Link")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color.purple)
                        .clipShape(Capsule())
                        .padding()
                })
                Spacer()
                // Got to sign up
                Button (action: {mode.wrappedValue.dismiss()}, label: {
                    HStack{
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                        
                    }.foregroundColor(.white)
                }).padding(.bottom, 20)
            }
            .padding(.top, -50)
        }
        .onReceive(viewModel.$didSendResetPassword, perform: { _ in
            self.mode.wrappedValue.dismiss()
        })
    }
}


