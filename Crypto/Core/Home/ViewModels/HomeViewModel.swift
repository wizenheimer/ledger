//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Nayan on 24/05/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    
    // this is made private because we don't want the callers
    // to own cancellation triggers via Home View Model
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(searchTerm: String, coins: [CoinModel]) -> [CoinModel] {
        if searchTerm.isEmpty {
            return coins
        }
        
        let lowerCasedSearchTerm = searchTerm.lowercased()
        return coins.filter {
            $0.name.lowercased().contains(lowerCasedSearchTerm) ||
            $0.symbol.lowercased().contains(lowerCasedSearchTerm) ||
            $0.id.lowercased().contains(lowerCasedSearchTerm)
        }
    }
}
