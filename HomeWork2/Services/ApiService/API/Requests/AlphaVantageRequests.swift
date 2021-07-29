//
//  AlphaVantageRequests.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 15.07.2021.
//

import Foundation

open class AlphaVantageRequests {
    open class func getCompanyOverview(symbol: String,
                                       apiResponseQueue: DispatchQueue = StockAPI.apiResponseQueue,
                                       completion: @escaping ((_ data: Company?, _ error: Error?) -> Void)) {
        getCompanyOverviewWithRequestBuilder(symbol: symbol).execute(apiResponseQueue) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
    
    open class func getIPOCalendar(apiResponseQueue: DispatchQueue = StockAPI.apiResponseQueue,
                                completion: @escaping ((_ data: Data?, _ error: Error?) -> Void)) {
        getCalendarWithRequestBuilder().execute(apiResponseQueue) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }

    open class func getCompanyOverviewWithRequestBuilder(symbol: String) -> RequestBuilder<Company> {
        let apiKey = StockAPI.AlphaVantageAPI.apiKey
        let URLString = StockAPI.AlphaVantageAPI.basePath
        let parameters: [String: Any]? = nil

        var urlComponents = URLComponents(string: URLString)
        urlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "function": "OVERVIEW".encodeToJSON(),
            "symbol": symbol.encodeToJSON(),
            "apikey": apiKey.encodeToJSON(),
        ])

        let nillableHeaders: [String: Any?] = [:]

        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Company>.Type = StockAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (urlComponents?.string ?? URLString), parameters: parameters, headers: headerParameters)
    }
    
    open class func getCalendarWithRequestBuilder() -> RequestBuilder<Data> {
        let apiKey = StockAPI.AlphaVantageAPI.apiKey
        let URLString = StockAPI.AlphaVantageAPI.basePath
        let parameters: [String: Any]? = nil

        var urlComponents = URLComponents(string: URLString)
        urlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "function": "IPO_CALENDAR".encodeToJSON(),
            "apikey": apiKey.encodeToJSON(),
        ])

        let nillableHeaders: [String: Any?] = [:]

        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Data>.Type = StockAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "GET", URLString: (urlComponents?.string ?? URLString), parameters: parameters, headers: headerParameters)
    }
}
