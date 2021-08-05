//
//  CalendarModel.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 16.07.2021.
//

import SwiftUI
import CSV
import CoreServicePackage

final class CalendarModel: ObservableObject {
    @Resolved
    var apiService: ApiServiceProtocol
    
    func requestData(_ callback: @escaping ([IPOData]) -> Void) {
        apiService.getIPOCalendar { data, error in
            guard let data = data else { return }
            
            let stream = InputStream(data: data)
            let csv = try! CSVReader(stream: stream, hasHeaderRow: true)
            
            var tempIPOData: [IPOData] = []
            
            while let row = csv.next() {
                if let ipoItem = IPOData(row: row) {
                    tempIPOData.append(ipoItem)
                }
            }
            
            callback(tempIPOData)
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
