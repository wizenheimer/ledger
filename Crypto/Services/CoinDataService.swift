//
//  CoinDataService.swift
//  Crypto
//
//  Created by Nayan on 24/05/25.
//

import Foundation
import Combine

class CoinDataService {
    
    // We are adding this here, so that this becomes a publisher and can be subscribed to
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                
                // Once we have the data, there's no point listening to the URL
                self?.coinSubscription?.cancel()
            })
    }
    
    func refresh() {
        getCoins()
    }
}
