//
//  HomeViewModel.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 8.07.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    private let dataService = CoinDataService()
    private var cancellables: Set<AnyCancellable> = .init()
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText = ""
    
    init() {
       addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$allCoins.sink { [unowned self] (coins) -> Void in
            self.allCoins = coins
        }.store(in: &cancellables)
    }
}
