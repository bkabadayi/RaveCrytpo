//
//  CoinImageView.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 9.07.2023.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var viewModel: CoinImageViewModel
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let imageData = viewModel.imageData {
                let image = UIImage(data: imageData)!
                Image(uiImage: image).resizable()
                                     .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark").foregroundColor(.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin).padding()
                                     .previewLayout(.sizeThatFits)
    }
}
