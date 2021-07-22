//
//  CalendarModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 16.07.2021.
//

import SwiftUI
import CSV

final class CalendarModel: ObservableObject {
    @Published var ipoData: [IPOData]   = .init()
    
    func requestData() {
        guard ipoData.count == 0 else { return }

        AlphaVantageRequests.getIPOCalendar { [weak self] data, error in
            guard let self = self, let data = data else { return }
            
            let stream = InputStream(data: data)
            let csv = try! CSVReader(stream: stream, hasHeaderRow: true)
            
            while let row = csv.next() {
                if let ipoItem = IPOData(row: row) {
                    self.ipoData.append(ipoItem)
                }
            }
        }
    }
}

struct IPOData: Identifiable {
    var id: String { return symbol }
    let symbol  : String
    let date    : String
    let name    : String
    
    init?(row: [String]?) {
        guard let row = row, row.count > 4 else { return nil }
        
        self.symbol = row[0]
        self.date = row[2]
        self.name = row[1]
    }
}
