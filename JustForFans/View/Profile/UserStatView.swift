//
//  UserStatView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/21/22.
//

import SwiftUI

struct UserStatView: View {
    let value : Int
    let title: String
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 15 , weight: .semibold))
                .foregroundColor(Color("AdaptiveBlack"))
            Text (title)
                .font(.system(size: 15))
                .foregroundColor(Color("AdaptiveBlack"))
        }.frame(width: 80, alignment: .center)
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(value: 1, title: "Posts")
    }
}
