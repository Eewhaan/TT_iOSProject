//
//  QuoteMapper.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import Foundation

struct QuoteMapper {
    static func map(_ attributeDict: [String : String]) -> Quote? {
        guard
            let last = Double(attributeDict["last"] ?? ""),
            let low = Double(attributeDict["low"] ?? ""),
            let high = Double(attributeDict["high"] ?? ""),
            let dateTime = attributeDict["dateTime"] else {
                print("Quote mandatory data is missing")
                return nil
            }
        
        let bid = Double(attributeDict["bid"] ?? "")
        let ask = Double(attributeDict["ask"] ?? "")
        let volume = Int(attributeDict["volume"] ?? "")
        let change = Double(attributeDict["change"] ?? "")
        let changePercent = Double(attributeDict["changePercent"] ?? "")
        
        return Quote(last: last,
                     low: low,
                     high: high,
                     dateTime: dateTime.toDate(),
                     bid: bid,
                     ask: ask,
                     volume: volume,
                     change: change,
                     changePercent: changePercent)
    }
}
