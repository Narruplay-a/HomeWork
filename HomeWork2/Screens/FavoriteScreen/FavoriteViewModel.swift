//
//  FavoriteViewModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 05.08.2021.
//

import SwiftUI
import Combine
import CoreServicePackage

final class FavoriteViewModel: ObservableObject {
    var model   : FavoriteModel = FavoriteModel()
    
    @Published
    var data    : [Stock]       = []

    func loadData() {
        data = model.getFavoriteData()
    }
    
    func removeFromFavorite(_ offset: IndexSet) {
        model.removeFromFavorite(offset)
        data = model.getFavoriteData()
    }
}
