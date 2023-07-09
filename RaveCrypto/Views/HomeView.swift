//
//  HomeView.swift
//  RaveCrypto
//
//  Created by Berkin Kabadayı on 5.07.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio = false
    
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $viewModel.searchText)
                columnTitles
                
                if !showPortfolio {
                    allCoinsList.transition(.move(edge: .leading))
                } else {
                    portfolioCoinsList.transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(CircleButtonAnimationView(animate: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }.padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                let inset: EdgeInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 10)
                
                CoinRowView(coin: coin, showHoldingsColumn: false).listRowInsets(inset)
                
            }
        }.listStyle(.inset)
         .transition(.move(edge: .leading))
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                let inset: EdgeInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 10)
                
                CoinRowView(coin: coin, showHoldingsColumn: true).listRowInsets(inset)
                
            }
        }.listStyle(.inset)
         .transition(.move(edge: .leading))
    }

    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price").frame(width: UIScreen.main.bounds.width / 3.5,
                                alignment: .trailing)
        }.font(.caption)
         .foregroundColor(.theme.secondaryText)
         .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .toolbar(.hidden)
        }.environmentObject(dev.homeViewModel)
    }
}
