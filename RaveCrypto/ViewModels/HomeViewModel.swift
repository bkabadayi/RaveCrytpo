//
//  HomeViewModel.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 8.07.2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.standard.coin)
            self.portfolioCoins.append(DeveloperPreview.standard.coin)
        }
    }
}
