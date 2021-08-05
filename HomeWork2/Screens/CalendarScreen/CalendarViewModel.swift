//
//  CalendarViewModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 05.08.2021.
//

import SwiftUI
import CSV
import CoreServicePackage

final class CalendarViewModel: ObservableObject {
    var model: CalendarModel = .init()
    
    @Published
    var ipoData: [IPOData]   = []
    
    func requestData() {
        guard ipoData.count == 0 else { return }

        model.requestData { [weak self] data in
            guard let self = self else { return }
            
            self.ipoData = data
        }
    }
}

