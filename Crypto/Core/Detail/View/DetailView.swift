//
//  DetailView.swift
//  Crypto
//
//  Created by Nayan on 25/05/25.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @State var vm: DetailViewModel
    
    init(coin: CoinModel) {
        _vm = .init(wrappedValue: .init(coin: coin))
    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLoadingView(coin: .constant(dev.coin))
    }
}
