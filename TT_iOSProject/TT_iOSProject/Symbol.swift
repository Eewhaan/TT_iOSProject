//
//  Symbol.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 13.3.22..
//

import Foundation


struct Symbol {
    var attributes = SymbolAttrs()
    var quote = Quote()
    
}

struct SymbolAttrs {
    var id: String = ""
    var name: String = ""
    var tickerSymbol: String = ""
    var isin: String = ""
    var currency: String = ""
    var stockExchangeName: String = ""
    var decorativeName: String = ""
}
struct Quote {
    var quoteAttrs = QuoteAttrs()
}

struct QuoteAttrs {
    var last: Double = 0.0
    var high: Double = 0.0
    var low: Double = 0.0
    var bid: Double = 0.0
    var ask: Double = 0.0
    var volume: Int = 0
    var dateTime: String = ""
    var change: Double = 0.0
    var changePercent: Double = 0.0
}
