//
//  StockListModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import SwiftUI
import Combine
import CoreServicePackage

final class StockListModel: ObservableObject {
    @Resolved
    var apiService          : ApiServiceProtocol
    @Resolved
    var storeService        : StoreProtocol
    
    var usaRequestOffset    : Int                   = 0
    var russiaRequestOffset : Int                   = 0
    
    var usaStockData        : [Stock]               = []
    var russiaStockData     : [Stock]               = []
    
    var favoriteStocks      : [Stock]               = []
    
    var cancellable         : AnyCancellable?
    
    init() {
        cancellable = (storeService as! StoreService).$favoriteData
            .sink { [weak self] list in
                guard let self = self else { return }
                
                self.favoriteStocks = list
            }
    }

    func requestData(_ exchange: SelectedCountry, callback: @escaping () -> Void) {
        apiService.getStockList(exchange: exchange.rawValue,
                                outputSize: 20,
                                offset: exchange == .russia ? russiaRequestOffset : usaRequestOffset) { [weak self] list, _ in
            guard let self = self else { return }
            
            switch exchange {
            case .russia:
                self.russiaRequestOffset += 20
                self.russiaStockData.append(contentsOf: list?.data ?? [])
            case .usa:
                self.usaRequestOffset    += 20
                self.usaStockData.append(contentsOf: list?.data ?? [])
            }
            
            callback()
        }
    }
    
    func isStockIsFavorite(_ symbol: String) -> Bool {
        return storeService.isFavorite(symbol)
    }
    
    func addToFavorite(_ stock: Stock) {
        storeService.addToFavorite(stock)
        storeService.saveFavoriteData()
    }
}

enum SelectedCountry: String {
    case usa    = "XNYS"
    case russia = "MISX"
}
