//
//  EmptySetView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/31/22.
//

import SwiftUI

struct EmptySetView: View {
    var body: some View {
        VStack {
            Text("No Messages, yet.")
                .font(.title)
                .padding()
            
            Text("No messages in your inbox, yet! Click the button below to start chatting with users around you")
                .foregroundColor(Color(.systemGray2))
                .font(.title3)
                .multilineTextAlignment(.center)
        }
    }
}

struct EmptySetView_Previews: PreviewProvider {
    static var previews: some View {
        EmptySetView()
    }
}
