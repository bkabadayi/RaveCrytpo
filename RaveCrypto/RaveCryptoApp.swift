//
//  RaveCryptoApp.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 5.07.2023.
//

import SwiftUI

@main
struct RaveCryptoApp: App {
    
    @StateObject private var viewModel: HomeViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden)
            }.environmentObject(viewModel)
        }
    }
}
