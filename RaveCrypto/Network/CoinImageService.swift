//
//  CoinImageService.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 9.07.2023.
//

import Foundation
import Combine

class CoinImageService {
    
    @Published var imageData: Data?
    private static let folderName = "coin_images"
    private var imageSubscription: AnyCancellable?
    private let localFileManager = LocalFileManager.standard
    
    init(coin: CoinModel) {
        getCoinImage(coin: coin)
    }
    
    private func getCoinImage(coin: CoinModel) {
        if let imageData = localFileManager.getImageData(imageName: coin.id, folderName: Self.folderName) {
            self.imageData = imageData
        } else {
            downloadCoinImage(coin: coin)
        }
    }
    
    private func downloadCoinImage(coin: CoinModel) {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url) { [unowned self] (data: Data) -> Void in
            self.imageData = data
            self.imageSubscription?.cancel()
            self.localFileManager.saveImage(imageData: data, imageName: coin.id, folderName: Self.folderName)
        }
    }
}
