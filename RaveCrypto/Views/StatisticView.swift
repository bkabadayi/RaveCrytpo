//
//  StatisticView.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 9.07.2023.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundColor(.theme.accent)
            
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(.init(degrees: (stat.percentageChange ?? 0) >= 0 ?
                                                    0 :
                                                    180))
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ?
                             .theme.green :
                             .theme.red)
            .opacity(stat.percentageChange == nil ?
                     0.0:
                     1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.stat)
        }
    }
}
