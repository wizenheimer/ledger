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
    @Published var isLoading: Bool = false
    
    @Published var sortOption: SortOption = .holdings // Items with highest holding are at top
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    // this is made private because we don't want the callers
    // to own cancellation triggers via Home View Model
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        
        // updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoins(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.refresh()
        marketDataService.refresh()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(searchTerm: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var filteredCoins = filterCoins(searchTerm: searchTerm, coins: coins)
        sortCoins(sort: sort, coins: &filteredCoins) // in-place sorting
        return filteredCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        }
    }
    
    private func sortPortfolioCoins(coins: [CoinModel]) -> [CoinModel] {
        // we will only sort by holding or reversedHolding if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
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
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioCoins: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioCoins.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapGlobalMarketData(
        data: MarketDataModel?,
        portfolioCoins: [CoinModel]
    ) -> [StatisticModel] {
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
        
        let portfolioValue = portfolioCoins.map{ $0.currentHoldingsValue }.reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentageChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentageChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = 100 * (portfolioValue - previousValue) / previousValue
        
        let portfolioStat = StatisticModel(
            title: "Portfolio Value",
            value: "$" + portfolioValue.formattedWithAbbreviations(),
            percentageChange: percentageChange)
        
        
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
