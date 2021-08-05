//
//  CompanyDetailViewModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 05.08.2021.
//

import SwiftUI
import CoreServicePackage

final class CompanyDetailViewModel: ObservableObject {
    var model   : CompanyDetailModel = .init()
    
    @Published
    var company : Company

    init(company: Company) {
        self.company = company
    }
}
