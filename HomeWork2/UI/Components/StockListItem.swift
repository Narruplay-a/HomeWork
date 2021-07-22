//
//  StockListItem.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import SwiftUI

struct StockListItem: View {
    @EnvironmentObject var storeService: StoreService
    
    let stock: Stock
    @State var hideFavoriteIcon = false

    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 10) {
                Text("Тикер:")
                    .font(.system(.caption))
                    .foregroundColor(.gray)
                Text(stock.symbol)
                    .font(.system(.headline))
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 10) {
                Text("Название:")
                    .font(.system(.caption))
                    .foregroundColor(.gray)
                Text(stock.name)
                    .font(.system(.headline))
            }
            
            if !hideFavoriteIcon && !storeService.isFavorite(stock.symbol) {
                Image("star")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.leading, 15)
                    .onTapGesture {
                        self.storeService.addToFavorite(stock)
                    }
            }
        }
    }
}
