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
        $searchText.combineLatest(dataService.$allCoins)
                   .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
                   .map { (text, startingCoins) in
                          guard !text.isEmpty else { return }
                           
                          return startingCoins.filter { (coin) -> Bool in
                              return coin.name.lowercased().contains(text.lowercased()) ||
                              coin.symbol.lowercased().contains(text.lowercased()) ||
                              coin.id.lowercased().contains(text.lowercased())
                          }
                   }
                   .sink { [unowned self] (coins) -> Void in
                           self.allCoins = coins
                   }
                   .store(in: &cancellables)
    }
}
