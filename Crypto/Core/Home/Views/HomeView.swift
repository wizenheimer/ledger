//
//  HomeView.swift
//  Crypto
//
//  Created by Nayan on 24/05/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false // Sheet
    
    var body: some View {
        ZStack {
            // Background Layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }

            
            // Content Layer
            VStack {
                // Header for Home View
                homeHeader
                
                // Home Stats View
                HomeStatsView()
                
                // Search for Home View
                SearchBarView(searchText: $vm.searchText)
                
                // Columns for the Coins Lables
                columnTitles
                
                // Data List for Coins
                if !showPortfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                } else {
                    portfolioCoinsList
                    .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            
            Spacer()
            
            Text(showPortfolio ? "Portfolio" :"Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(
                        top: 10,
                        leading: 0,
                        bottom: 10,
                        trailing: 10
                    ))
            }
            
        }
        .listStyle(.plain)
        .refreshable {
            await Task {
                vm.reloadData()
                // Small delay to let the refresh indicator show properly
                try? await Task.sleep(nanoseconds: 300_000_000)
                // 0.3 seconds
            }.value
        }
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(
                        top: 10,
                        leading: 0,
                        bottom: 10,
                        trailing: 10
                    ))
            }
            
        }
        .listStyle(.plain)
        .refreshable {
            await Task {
                vm.reloadData()
                // Small delay to let the refresh indicator show properly
                try? await Task.sleep(nanoseconds: 300_000_000)
                // 0.3 seconds
            }.value
        }
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            
            Button(
                action: {
                    withAnimation(.linear(duration: 2.0)) {
                        vm.reloadData()
                    }
                }, label: {
                    Image(systemName: "goforward")
                }
            )
            .rotationEffect(
                Angle(degrees: vm.isLoading ? 360 : 0),
                anchor: .center
            )
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
