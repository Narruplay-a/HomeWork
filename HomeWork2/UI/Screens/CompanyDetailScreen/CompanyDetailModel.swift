//
//  CompanyDetailModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import SwiftUI

final class CompanyDetailModel: ObservableObject {
    @Published var company: Company

    init(company: Company) {
        self.company = company
    }
}
