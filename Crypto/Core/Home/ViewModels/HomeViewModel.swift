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
    
    @Published var statistics: [StatisticModel] = []
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    // this is made private because we don't want the callers
    // to own cancellation triggers via Home View Model
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // Updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Updates marketData
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
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
    
    private func mapGlobalMarketData(data: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = data else {
            return stats
        }
        
        let marketCapStat = StatisticModel(
                title: "Market Cap",
                value: data.marketCap,
                percentageChange: data.marketCapChangePercentage24HUsd)
            
        let volumeStat = StatisticModel(
            title: "24h Volume",
            value: data.volume)
        
        let btcDominanceStat = StatisticModel(
            title: "BTC Dominance",
            value: data.btcDominance)
        
        let ethDominanceStat = StatisticModel(
            title: "ETH Dominance",
            value: data.ethDominance)
        
        let usdtDominanceStat = StatisticModel(
            title: "USDT Dominance",
            value: data.usdtDominance)
        
        let altcoinDominanceStat = StatisticModel(
            title: "Altcoin Share",
            value: data.altcoinDominance)
        
        let activeCoinsStat = StatisticModel(
            title: "Active Coins",
            value: data.activeCryptocurrenciesFormatted)
        
        let marketsStat = StatisticModel(
            title: "Markets",
            value: data.marketsFormatted)
        
        let volumeRatioStat = StatisticModel(
            title: "Vol/MCap",
            value: data.volumeToMarketCapRatio)
        
        let ongoingIcosStat = StatisticModel(
            title: "Ongoing ICOs",
            value: data.ongoingIcosFormatted)
        
        let portfolioStat = StatisticModel(
            title: "Portfolio Value",
            value: "$123.4",
            percentageChange: 12.34)
        
        stats.append(contentsOf: [
            marketCapStat,
            volumeStat,
            btcDominanceStat,
            ethDominanceStat,
            usdtDominanceStat,
            altcoinDominanceStat,
            activeCoinsStat,
            marketsStat,
            volumeRatioStat,
            ongoingIcosStat,
            portfolioStat,
        ])
        
        return stats
    }
}
