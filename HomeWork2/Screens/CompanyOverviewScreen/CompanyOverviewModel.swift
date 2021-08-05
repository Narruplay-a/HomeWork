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

    func loadCompanyData(symbol: String, callback: @escaping (Company?) -> Void) {
        apiService.getCompanyOverview(symbol: symbol) { company, error in
            callback(company)
        }
    }
}

