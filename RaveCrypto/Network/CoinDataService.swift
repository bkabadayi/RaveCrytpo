//
//  CoinDataService.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 8.07.2023.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    private var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }
        
        coinSubscription = NetworkingManager.download(url: url, dataType: [CoinModel].self) { [unowned self] (coins) -> Void in
            self.allCoins = coins
            self.coinSubscription?.cancel()
        }
    }
}
