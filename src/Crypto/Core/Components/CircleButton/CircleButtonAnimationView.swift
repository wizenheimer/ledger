//
//  CircleButtonAnimationView.swift
//  Crypto
//
//  Created by Nayan on 24/05/25.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? .easeInOut(duration: 1.0) : .none, value: animate)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(true))
        .foregroundColor(.red)
        .frame(width: 100, height: 100)
}
