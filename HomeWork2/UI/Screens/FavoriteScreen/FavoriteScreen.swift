//
//  FavoriteScreen.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 19.07.2021.
//

import SwiftUI

struct FavoriteScreen: View {
    @ObservedObject var model: FavoriteModel
    @EnvironmentObject var navigationService: NavigationService
    @EnvironmentObject var storeService: StoreService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            List {
                ForEach(model.data, id: \.id) { stock in
                    StockListItem(stock: stock)
                        .onTapGesture {
                            self.navigationService.show(view:
                                                            CompanyOverviewScreen(model: CompanyOverviewModel(symbol: stock.symbol)).anyView)
                        }
                }.onDelete { offset in
                    storeService.removeFromFavorite(offset)
                }
            }
            .padding(.top, 20)
            .frame(maxHeight: .infinity)
        }
        .onAppear {
            navigationService.updateNavigation(with: "Избранное")
        }
    }
    
    static var tabItem: some View {
        VStack {
            Image(systemName: "star")
            Text("Избранное")
        }
    }
}

