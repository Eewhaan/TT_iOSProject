//
//  Symbol.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import Foundation

struct Symbol {
    let id: String
    let name: String
    let tickerSymbol: String
    let currency: String
    let stockExchangeName: String
    let decorativeName: String
    let isin: String?
    var quote: Quote?
}
