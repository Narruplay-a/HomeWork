//
//  CompanyOverviewViewModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 05.08.2021.
//

import SwiftUI
import CoreServicePackage

final class CompanyOverviewViewModel: ObservableObject {
    @Published
    var company       : Company?
    @Published
    var isDataLoading : Bool                  = true
    @Published
    var isDataEmpty   : Bool                  = false
    
    let symbol        : String
    let model         : CompanyOverviewSerice = .init()
    
    init(symbol: String) {
        self.symbol = symbol
    }
    
    func loadCompanyData() {
        guard company == nil else { return }
        
        isDataLoading = true
        model.loadCompanyData(symbol: symbol) { [weak self] company in
            guard let self = self else { return }
            
            self.isDataLoading = false
            if let company = company {
                self.company = company
            } else {
                self.isDataEmpty = true
            }
        }
    }
}
