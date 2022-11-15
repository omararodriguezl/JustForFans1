//
//  SeachView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/20/22.
//

import SwiftUI

struct SeachView: View {
    @State var searchText = ""
    @State var inSearchMode = false
    @ObservedObject var viewModel = SearchViewModel(config: .search)
    var body: some View {
        
        ScrollView {
            // Seach bar
            SeachBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            ZStack {
                if inSearchMode{
                    UserListView (viewModel: viewModel, searchText: $searchText)
                }else {
                    PostGridView(config: .explore)
                }
            }
        }
    }
}

struct SeachView_Previews: PreviewProvider {
    static var previews: some View {
        SeachView()
    }
}
