//
//  SymbolMapper.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import Foundation

struct SymbolMapper {
    static func map(_ attributeDict: [String : String]) -> Symbol? {
        guard
            let id = attributeDict["id"],
            let name = attributeDict["name"],
            let tickerSymbol = attributeDict["tickerSymbol"],
            let currency = attributeDict["currency"],
            let stockExchangeName = attributeDict["stockExchangeName"],
            let decorativeName = attributeDict["decorativeName"] else {
                print("Symbol mandatory data is missing")
                return nil
            }
        
        let isin = attributeDict["isin"]
        
        return Symbol(id: id,
                      name: name,
                      tickerSymbol: tickerSymbol,
                      currency: currency,
                      stockExchangeName: stockExchangeName,
                      decorativeName: decorativeName,
                      isin: isin,
                      quote: nil)
    }
}
