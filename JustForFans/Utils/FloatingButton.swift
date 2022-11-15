//
//  FloatingButton.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import SwiftUI

struct FloatingButton: View {
    @Binding var show: Bool
    
    var body: some View {
        Button(action: { show.toggle() }, label: {
            Image(systemName: "square.and.pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding()
        })
        .background(Color(.systemBlue))
        .foregroundColor(.white)
        .clipShape(Circle())
        .padding()
        
    }
}
