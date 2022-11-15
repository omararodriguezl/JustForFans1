//
//  RegistrationView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/22/22.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var userName = ""
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State var imagePickerPresented = false
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment (\.presentationMode) var mode
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors:[Color.red , Color.purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack (spacing: 15){
                ZStack{
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .padding(.top)
                    }else {
                        Button (action: {imagePickerPresented.toggle()}, label: {
                            VStack{
                                Image(systemName: "plus")
                                    .font(.title)
                                    .padding(.bottom, 4)
                                Text("Photo")
                                    .font(.headline)
                            }
                        }).padding(50)
                            .foregroundColor(.white)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .frame(width: 200, height: 200)
                            .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage , content: {
                                ImagePicker(image: $selectedImage , urlVideo: .constant(""))
                                
                            })
                    }
                }
                
                VStack (spacing: 20){
                    // Email Field
                    CustomTextField (text: $email, placeholder: Text ("Email"), imagName: "envelope")
                        .padding()
                        .background(Color (.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal , 32)
                    CustomTextField (text: $userName, placeholder: Text ("Username"), imagName: "person")
                        .padding()
                        .background(Color (.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal , 32)
                    CustomTextField (text: $fullName, placeholder: Text ("Full Name"), imagName: "person")
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
              
                //Sign in
                Button(action: {
                    viewModel.register(withEmail: email, password: password, image: selectedImage, fullName: fullName, userName: userName)
                }, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color.purple)
                        .clipShape(Capsule())
                        .padding()
                })
                Spacer()
                Button (action: {mode.wrappedValue.dismiss()}, label: {
                    HStack{
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                        
                    }.foregroundColor(.white)
                }).padding(.bottom, 20)
               
            }
        }
    }
}
extension RegistrationView {
    func loadImage() {
        guard let selectedImage = selectedImage else {return}
        image = Image(uiImage: selectedImage)
    }
}
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
