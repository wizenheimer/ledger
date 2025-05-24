//
//  UIApplication.swift
//  Crypto
//
//  Created by Nayan on 25/05/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    // Resign the first responder - dismissing the keyboard
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
