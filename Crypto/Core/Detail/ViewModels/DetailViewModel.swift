//
//  DetailViewModel.swift
//  Crypto
//
//  Created by Nayan on 25/05/25.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetail
            .sink { returnedCoinDetails in
                // TODO:
            }
            .store(in: &cancellables)
    }
}
