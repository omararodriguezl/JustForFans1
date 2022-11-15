//
//  Extensions.swift
//  JustForFans
//
//  Created by Omar Rodriguez on 10/21/22.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
