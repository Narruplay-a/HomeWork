//
//  CompanyOverviewModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import SwiftUI
import CoreServicePackage

final class CompanyOverviewModel: ObservableObject {
    @Resolved var apiService: ApiServiceProtocol
    
    @Published var company          : Company?
    @Published var isDataLoading    : Bool = true
    @Published var isDataEmpty      : Bool = false
    
    var symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
    }
    
    func loadCompanyData() {
        guard company == nil else { return }
        
        isDataLoading = true
        apiService.getCompanyOverview(symbol: symbol) { company, error in
            self.isDataLoading = false
            
            if let company = company {
                self.company = company
            } else {
                self.isDataEmpty = true
            }
        }
    }
}

