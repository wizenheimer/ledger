//
//  Color.swift
//  Crypto
//
//  Created by Nayan on 24/05/25.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("ColorGreen")
    let red = Color("ColorRed")
    let secondaryText = Color("SecondaryTextColor")
}
