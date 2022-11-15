//
//  LogInView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/22/22.
//

import SwiftUI

struct LogInView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors:[Color.red , Color.purple]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack (spacing: 15){
                   Image("JustForFansLogo")
                        .resizable()
                        .scaledToFill()
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
                        //Password Field
                        CustomSecureField(text: $password, placeholder: Text("Password"))
                            .padding()
                            .background(Color (.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal , 32)
                    }
                  
                    //forgot Password
                    HStack {
                        Spacer()
                        NavigationLink(destination: ResetPasswordView(email: $email), label: {
                            Text("Forgot Password ? ")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                                .padding(.trailing, 28)
                        })
                    }
                    //Sign in
                    Button(action: {
                        viewModel.longIn(withEmail: email, password: password)
                    }, label: {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color.purple)
                            .clipShape(Capsule())
                            .padding()
                    })
                    Spacer()
                    // Got to sign up
                        NavigationLink (
                            destination: RegistrationView().navigationBarHidden(true)
                            , label: {
                                HStack{
                                    Text("Don't have an account?")
                                        .font(.system(size: 14))
                                    Text("Sign Up")
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                }.foregroundColor(.white)
                            }).padding(.bottom, 20)
                }
                .padding(.top, 20)
            }
            
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
