//
//  HomeStatsView.swift
//  Crypto
//
//  Created by Nayan on 25/05/25.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(vm.statistics) { stat in
                        StatisticView(stat: stat)
                            .frame(width: 120)
                    }
                }
                .padding(.horizontal, 16)
            }
            .overlay(
                // Subtle gradient fade to indicate more content
                LinearGradient(
                    gradient: Gradient(colors: [Color.clear, Color(UIColor.systemBackground).opacity(0.8)]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: 20)
                .allowsHitTesting(false),
                alignment: .trailing
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeStatsView()
                .environmentObject(dev.homeVM)
            
            HomeStatsView()
                .environmentObject(dev.homeVM)
        }
    }
}
