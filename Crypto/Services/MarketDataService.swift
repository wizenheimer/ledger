//
//  MarketDataService.swift
//  Crypto
//
//  Created by Nayan on 25/05/25.
//

import SwiftUI
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel?
    
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalDataModel.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (returnedGlobalData) in
                    self?.marketData = returnedGlobalData.data
                    self?.marketDataSubscription?.cancel()
            })
    }
}
