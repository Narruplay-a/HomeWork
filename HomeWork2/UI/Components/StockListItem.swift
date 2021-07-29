//
//  StockListItem.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import SwiftUI
import CoreServicePackage

struct StockListItem: View {
    @Resolved var storeService: StoreProtocol
    
    @State var reloadCell = false
    var hideFavoriteIcon = false
    let stock: Stock

    var body: some View {
        HStack() {
            if reloadCell { }
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
                        self.reloadCell.toggle()
                        self.storeService.addToFavorite(stock)
                    }
            }
        }
    }
}
