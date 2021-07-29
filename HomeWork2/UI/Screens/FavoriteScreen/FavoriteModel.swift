//
//  FavoriteModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 19.07.2021.
//

import SwiftUI
import Combine
import CoreServicePackage

final class FavoriteModel: ObservableObject {
    @Resolved var storeService: StoreProtocol
    @Published var data: [Stock] = []
    
    private var cancellable: AnyCancellable?
    
    init() {
        data = storeService.favoriteData
        
        if let storeService = storeService as? StoreService {
            cancellable = storeService.$favoriteData.assign(to: \.data, on: self)
        }
    }
}
