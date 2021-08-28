//
//  StockListViewModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 05.08.2021.
//


import SwiftUI
import Combine
import CoreServicePackage

final class StockListViewModel: ObservableObject {
    var model                : StockListService     = StockListService()
    
    @Published
    var stockData            : [Stock]              = []
    @Published
    var isDataLoading        : Bool                 = false
    @Published
    var segmentSelectedIndex : Int                  = 0 {
        didSet {
            countrySelectiondDidChange()
        }
    }

    var selectedCountry      : SelectedCountry      = .usa

    func requestData(initial: Bool) {
        guard stockData.count == 0 || !initial else { return }
        
        model.requestData(selectedCountry) { [weak self] in
            guard let self = self else { return }
            
            self.stockData = self.selectedCountry == .usa ? self.model.usaStockData : self.model.russiaStockData
        }
    }
    
    func isStockIsFavorite(_ symbol: String) -> Bool {
        return model.isStockIsFavorite(symbol)
    }
    
    func addToFavorite(_ symbol: String) {
        if let stock = stockData.first(where: { stockItem in
            return stockItem.symbol == symbol
        }) {
            model.addToFavorite(stock)
        }
    }
}

private extension StockListViewModel {
    func countrySelectiondDidChange() {
        switch segmentSelectedIndex {
        case 0:
            stockData       = model.usaStockData
            selectedCountry = .usa
        default:
            stockData       = model.russiaStockData
            selectedCountry = .russia
        }
        
        if stockData.isEmpty {
            model.requestData(selectedCountry) { [weak self] in
                guard let self = self else { return }
                
                self.stockData = self.selectedCountry == .usa ? self.model.usaStockData : self.model.russiaStockData
            }
        }
    }
}
