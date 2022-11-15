//
//  LazyView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/28/22.
//

import SwiftUI

struct LazyView<Content:View> : View {
    let build: () -> Content
    init (_ build: @autoclosure @escaping() -> Content){
        self.build = build
    }
    var body: Content {
        build()
    }
}
