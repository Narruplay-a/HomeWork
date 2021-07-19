//
//  FavoriteModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 19.07.2021.
//

import SwiftUI
import Combine

final class FavoriteModel: ObservableObject {
    @Published var data: [Stock] = []
    
    private var cancellable: AnyCancellable?
    
    init(_ storeService: StoreService) {
        data = storeService.favoriteData
        cancellable = storeService.$favoriteData.assign(to: \.data, on: self)
    }
}
