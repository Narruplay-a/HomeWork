//
//  CompanyOverviewModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import SwiftUI
import Combine

final class CompanyOverviewModel: ObservableObject {
    @Published var company: Company?
    @Published var isDataLoading: Bool = true
    
    var symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
    }
    
    func loadCompanyData() {
        guard company == nil else { return }
        
        isDataLoading = true
//        AlphaVantageRequests.getCompanyOverview(symbol: symbol) { company, error in
//            self.company = company
//            self.isDataLoading = false
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let data = mockCompanyString.data(using: .utf8)!
            self.company = try? CodableHelper.decode(Company.self, from: data).get()
            self.isDataLoading = false
        }
    }
}

