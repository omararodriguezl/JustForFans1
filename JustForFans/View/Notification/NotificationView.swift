//
//  NotificationView.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/20/22.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var viewModel = NotificationViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack {
                ForEach (viewModel.notification){ notification in
                    NotificationCell(viewModel:  NotificationCellViewModel(notification: notification))
                        .padding(.top)
                }
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
