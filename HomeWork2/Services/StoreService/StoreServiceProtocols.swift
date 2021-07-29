//
//  StoreServiceProtocols.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 29.07.2021.
//

import Foundation

protocol StoreProtocol {
    var favoriteData: [Stock] { get set }
    
    func addToFavorite(_ stock: Stock)
    func removeFromFavorite(_ offset: IndexSet)
    func isFavorite(_ symbol: String) -> Bool
    func saveFavoriteData()
    func loadFavoriteData()
}
