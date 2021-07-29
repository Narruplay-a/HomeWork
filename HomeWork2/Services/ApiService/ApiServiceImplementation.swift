//
//  ApiServiceImplementation.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 29.07.2021.
//

import Foundation

final class ApiService: ApiServiceProtocol {
    func getStockList(exchange: String, outputSize: Int, offset: Int, completion: @escaping ((_ data: StockList?, _ error: Error?) -> Void)) {
        MarketstackRequests.getStockListWithRequestBuilder(exchange: exchange,
                                                           outputSize: outputSize,
                                                           offset: offset)
            .execute(DispatchQueue.main) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
    
    func getIPOCalendar(completion: @escaping ((_ data: Data?, _ error: Error?) -> Void)) {
        AlphaVantageRequests.getCalendarWithRequestBuilder().execute(DispatchQueue.main) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
    
    func getCompanyOverview(symbol: String, completion: @escaping ((_ data: Company?, _ error: Error?) -> Void)) {
        AlphaVantageRequests.getCompanyOverviewWithRequestBuilder(symbol: symbol).execute(DispatchQueue.main) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
