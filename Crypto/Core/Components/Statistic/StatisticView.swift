//
//  StatisticView.swift
//  Crypto
//
//  Created by Nayan on 25/05/25.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text(stat.percentageChange?.asPercentageString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.statWithPositivePercentageChange)
                .previewDisplayName("Stat with Positive Percentage Change")
            
            StatisticView(stat: dev.statWithNegativePercentageChange)
                .previewDisplayName("Stat with Negative Percentage Change")
            
            StatisticView(stat: dev.statWithNoPercentageChange)
                .previewDisplayName("Stat with No Percentage Change")
        }
    }
}
