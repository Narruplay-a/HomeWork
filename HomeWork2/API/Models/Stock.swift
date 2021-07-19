//
// Recipe.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

//"name":"Microsoft Corporation",
//    "symbol":"MSFT",
//    "has_intraday":false,
//    "has_eod":true,
//    "country":null,
//    "stock_exchange":{"name":"NASDAQ Stock Exchange",
//        "acronym":"NASDAQ",
//        "mic":"XNAS",
//        "country":"USA",
//        "country_code":"US",
//        "city":"New York",
//        "website":"www.nasdaq.com"}

public struct Stock: Codable, Identifiable {
    public var id: String {
        return symbol
    }
    
    public var name: String
    public var symbol: String
    public var has_intraday: Bool
    public var has_eod: Bool
    public var country: String?
    public var stock_exchange: StockExchange?
}
