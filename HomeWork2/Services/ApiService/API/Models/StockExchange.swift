//
//  StockExchange.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 14.07.2021.
//

import Foundation
//{"name":"NASDAQ Stock Exchange",
//        "acronym":"NASDAQ",
//        "mic":"XNAS",
//        "country":"USA",
//        "country_code":"US",
//        "city":"New York",
//        "website":"www.nasdaq.com"}


public struct StockExchange: Codable {
    public var name: String
    public var acronym: String
    public var mic: String
    public var country: String
    public var country_code: String
    public var city: String
    public var website: String
}
