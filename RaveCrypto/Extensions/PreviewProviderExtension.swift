//
//  PreviewProviderExtension.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 6.07.2023.
//

import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.standard
    }
}

class DeveloperPreview {
    static let standard = DeveloperPreview()
    
    let homeViewModel: HomeViewModel = .init()
    
    let coin = CoinModel(id: "bitcoin",
                         symbol: "btc",
                         name: "Bitcoin",
                         image: "https://assets.coingecko.com/coin/images/1/large/bitcoin.png?1547033579",
                         currentPrice: 61408,
                         marketCap: 1141731099010,
                         marketCapRank: 1,
                         fullyDilutedValuation: 12858329,
                         totalVolume: 68239200,
                         high24H: 61712,
                         low24H: 56220,
                         priceChange24H: 3952.44,
                         priceChangePercentage24H: 6.872,
                         marketCapChange24H: 72110683439,
                         marketCapChangePercentage24H: 6.741,
                         circulationSupply: 18653043,
                         totalSupply: 21000000,
                         maxSupply: 21000000,
                         ath: 61712,
                         athChangePercentage: -097.589,
                         athDate: "2023-07-08T20:49:07.606Z",
                         atl: 67.81,
                         atlChangePercentage: 90020.2475,
                         atlDate: "2013-07-06T00:00:00.000Z",
                         lastUpdated: "2021-03-13T23:18:10.268Z",
                         sparklineIn7D: SparklineIn7D(price: [54019.26878365,
                                                              53729.26878365,
                                                              53301.26878365,
                                                              52818.26878365,
                                                              52519.26878365,
                                                              52319.26878365,
                                                              51900.26878365,
                                                              51619.26878365,
                                                              50419.26878365,
                                                              50219.26878365,
                                                              50002.26878365,
                                                              49982.26878365,
                                                              49277.26878365,
                                                              59089.26878365]),
                         priceChangePercentage24HInCurrency: 3952.64,
                         currentHoldings: 1.5)
    
    private init() { }
}
