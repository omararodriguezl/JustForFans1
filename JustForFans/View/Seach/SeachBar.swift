//
//  SeachBar.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/21/22.
//

import SwiftUI

struct SeachBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    var body: some View {
        HStack{
            TextField("Seach..." , text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading , 8)
                    }
                )
                .onTapGesture {
                    isEditing = true
                }
            if isEditing {
                Button (action: {
                    isEditing = false
                    text = ""
                    UIApplication.shared.endEditing()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(Color("AdaptiveBlack"))
                })
                    .padding(.trailing, 8)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
            }
        }
    }
}

struct SeachBar_Previews: PreviewProvider {
    static var previews: some View {
        SeachBar(text: .constant("Search"), isEditing: .constant(true))
    }
}
