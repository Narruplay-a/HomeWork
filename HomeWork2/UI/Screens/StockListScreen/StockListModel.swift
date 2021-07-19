//
//  StockListModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import SwiftUI
import Combine

final class StockListModel: ObservableObject {
    @Published var stockData: [Stock]               = []
    @Published var isDataLoading: Bool              = false
    @Published var segmentSelectedIndex: Int        = 0 {
        didSet {
            countrySelectiondDidChange()
        }
    }
    
    private var usaStockData: [Stock]               = []
    private var russiaStockData: [Stock]            = []
    private var usaRequestOffset: Int               = 0
    private var russiaRequestOffset: Int            = 0
    private var requestLimit: Int                   = 20
    private var selectedCountry: SelectedCountry    = .usa
    private var cancellables: Set<AnyCancellable>   = .init()
    
    private var currentOffset: Int {
        return selectedCountry == .usa ? usaRequestOffset : russiaRequestOffset
    }
    
    var cancellable: AnyCancellable?
    
    
    func requestInitialData() {
        guard usaStockData.isEmpty && russiaStockData.isEmpty else { return }
        
        requestData()
    }
    
    func requestAdditionalData() {
        switch selectedCountry {
        case .usa:
            usaRequestOffset += 20
        case .russia:
            russiaRequestOffset += 20
        }
        
//        requestData()
    }
    
    deinit {
        cancellables.cancelAll()
    }
}

private extension StockListModel {
    func requestData() {
        isDataLoading = true
        
    
        
//        MarketstackRequests.getStockList(exchange: selectedCountry.rawValue, outputSize: requestLimit, offset: currentOffset) { [weak self] list, _ in
//            guard let self = self, let stocks = list?.data else { return }
//
//            switch self.selectedCountry {
//            case .usa:
//                self.usaStockData.append(contentsOf: stocks)
//                self.stockData = self.usaStockData
//            case .russia:
//                self.russiaStockData.append(contentsOf: stocks)
//                self.stockData = self.russiaStockData
//            }
//
//            self.isDataLoading = false
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let data = stockListTemp.data(using: .utf8)!
            let list = try? CodableHelper.decode(StockList.self, from: data).get()
            
            switch self.selectedCountry {
            case .usa:
                self.usaStockData.append(contentsOf: list!.data!)
                self.stockData = self.usaStockData
            case .russia:
                self.russiaStockData.append(contentsOf: list!.data!)
                self.stockData = self.russiaStockData
            }

            self.isDataLoading = false
        }
    }
    
    func countrySelectiondDidChange() {
        switch segmentSelectedIndex {
        case 0:
            selectedCountry = .usa
            stockData = usaStockData
            
        default:
            selectedCountry = .russia
            stockData = russiaStockData
        }
        
        if stockData.isEmpty {
            requestData()
        }
    }
}

enum SelectedCountry: String {
    case usa    = "XNYS"
    case russia = "MISX"
}
