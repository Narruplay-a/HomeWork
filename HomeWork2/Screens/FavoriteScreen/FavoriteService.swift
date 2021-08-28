//
//  FavoriteModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 19.07.2021.
//

import Foundation
import CoreServicePackage

final class FavoriteService {
    @Resolved
    var storeService        : StoreProtocol
    
    func getFavoriteData() -> [Stock] {
        return storeService.favoriteData
    }
    
    func removeFromFavorite(_ offset: IndexSet) {
        storeService.removeFromFavorite(offset)
        storeService.saveFavoriteData()
    }
}
