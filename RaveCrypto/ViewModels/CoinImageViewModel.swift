//
//  CoinImageViewModel.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 9.07.2023.
//

import Foundation
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var imageData: Data?
    @Published var isLoading: Bool = false
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        dataService = .init(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$imageData.sink(receiveCompletion: { [unowned self] (_) -> Void in
                                                         self.isLoading = false },
                                    receiveValue: { [unowned self] (imageData) -> Void in
                                                    self.imageData = imageData })
                              .store(in: &cancellables)
        
    }
}
