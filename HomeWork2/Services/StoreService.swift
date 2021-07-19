//
//  StoreService.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 19.07.2021.
//

import SwiftUI
import Combine

final class StoreService: ObservableObject {
    static let shared = StoreService()
    
    @Published var favoriteData: [Stock]    = []
    
    private var containsSet: Set<String>    = .init()
    private var cancellable: AnyCancellable?
    
    private init() {
        loadFavoriteData()
        cancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
            .sink { value in
                self.saveFavoriteData()
            }
    }
    
    func addToFavorite(_ stock: Stock) {
        favoriteData.append(stock)
        containsSet.insert(stock.symbol)
    }
    
    func removeFromFavorite(_ offset: IndexSet) {
        favoriteData.remove(atOffsets: offset)
        containsSet = Set(favoriteData.map { $0.symbol })
    }
    
    func isFavorite(_ symbol: String) -> Bool {
        return containsSet.contains(symbol)
    }
}

private extension StoreService {
    func saveFavoriteData() {
        let stockList = StockList(data: favoriteData)
        let payload: Data? = try? JSONEncoder().encode(stockList)
        
        UserDefaults.standard.set(payload, forKey: "favoriteData")
    }
    
    func loadFavoriteData() {
        guard let stockData = UserDefaults.standard.data(forKey: "favoriteData") else { return }
        
        if let stockList = try? JSONDecoder().decode(StockList.self, from: stockData) {
            favoriteData = stockList.data ?? []
        }
        
        containsSet = Set(favoriteData.map { $0.symbol })
    }
}
