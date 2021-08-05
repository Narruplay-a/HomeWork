//
//  FavoriteScreen.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 19.07.2021.
//

import SwiftUI
import CoreServicePackage
import HWUIComponents

struct FavoriteScreen: View {
    @ObservedObject var model       : FavoriteModel
    @Resolved var navigationService : NavigationProtocol
    @Resolved var storeService      : StoreProtocol
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                HStack {
                    Spacer()
                    Text("Избранное")
                        .lineLimit(0)
                        .font(.system(size: 18).bold())
                        .fixedSize(horizontal: false, vertical: false)
                        .padding(.bottom, 10)
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray.opacity(0.05))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            
            VStack(alignment: .leading, spacing: 0) {
                List {
                    ForEach(model.data, id: \.id) { stock in
                        StockListItem(symbol: stock.symbol, name: stock.name, hideFavoriteIcon: false)
                    }.onDelete { offset in
                        storeService.removeFromFavorite(offset)
                    }
                }
                .padding(.top, 20)
            }
            .frame(maxHeight: .infinity)
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
    }
    
    static var tabItem: some View {
        VStack {
            Image(systemName: "star")
            Text("Избранное")
        }
    }
}

