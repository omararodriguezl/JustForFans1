//
//  CustomInputView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/26/22.
//

import SwiftUI

struct CustomInputView: View {
    @Binding var inputText: String
    let placeholder: String
    var action: () -> Void

    var body: some View {
        VStack{
            // divider
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
                .padding()
            //hstack with send button and text field
            HStack{
                TextField(placeholder, text: $inputText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.body)
                    .frame(minWidth: 30)
                Button(action: action) {
                    Text("Send")
                        .bold()
                        .foregroundColor(Color("AdaptiveBlack"))
                }
            }
            .padding(.bottom , 8)
            .padding(.horizontal)
        }
    }
}
