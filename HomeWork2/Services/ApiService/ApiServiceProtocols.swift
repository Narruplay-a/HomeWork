//
//  ApiServiceProtocols.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 29.07.2021.
//

import Foundation

protocol ApiServiceProtocol {
    func getStockList(exchange: String, outputSize: Int, offset: Int, completion: @escaping ((_ data: StockList?, _ error: Error?) -> Void))
    func getIPOCalendar(completion: @escaping ((_ data: Data?, _ error: Error?) -> Void))
    func getCompanyOverview(symbol: String, completion: @escaping ((_ data: Company?, _ error: Error?) -> Void))
}


