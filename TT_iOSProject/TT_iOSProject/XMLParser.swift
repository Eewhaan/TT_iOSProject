//
//  XMLParser.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 13.3.22..
//

import Foundation

class SymbolsParser: XMLParser {
    public var symbols: [Symbol] = []
    
    private var symbol = Symbol()
    private var quote = Quote ()
    
    
    override init(data: Data) {
            super.init(data: data)
            self.delegate = self
        }
}

extension SymbolsParser: XMLParserDelegate {
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Symbol" {
            var tempSymbolAttr = SymbolAttrs()
            if let id = attributeDict["id"] {
                tempSymbolAttr.id = id
            }
            if let name = attributeDict["name"] {
                tempSymbolAttr.name = name
            }
            if let tickerSymbol = attributeDict["tickerSymbol"] {
                tempSymbolAttr.tickerSymbol = tickerSymbol
            }
            if let isin = attributeDict["isin"] {
                tempSymbolAttr.isin = isin
            }
            if let currency = attributeDict["currency"] {
                tempSymbolAttr.currency = currency
            }
            if let stockExchangeName = attributeDict["stockExchangeName"] {
                tempSymbolAttr.stockExchangeName = stockExchangeName
            }
            if let decorativeName = attributeDict["decorativeName"] {
                tempSymbolAttr.decorativeName = decorativeName
            }
            symbol.attributes = tempSymbolAttr
            
        } else if elementName == "Quote" {
            var tempQuoteAttr = QuoteAttrs()

            if let last = attributeDict["last"] {
                guard let lastNumber = Double(last) else {return}
                tempQuoteAttr.last = lastNumber
            }
            if let low = attributeDict["low"] {
                guard let double = Double(low) else {return}
                tempQuoteAttr.low = double
            }
            if let bid = attributeDict["bid"] {
                guard let double = Double(bid) else {return}
                tempQuoteAttr.bid = double
            }
            if let ask = attributeDict["ask"] {
                guard let double = Double(ask) else {return}
                tempQuoteAttr.ask = double
            }
            if let volume = attributeDict["volume"] {
                guard let integer = Int(volume) else {return}
                tempQuoteAttr.volume = integer
            }
            if let dateTime = attributeDict["dateTime"] {
                tempQuoteAttr.dateTime = dateTime
            }
            if let change = attributeDict["change"] {
                guard let double = Double(change) else {return}
                tempQuoteAttr.change = double
            }
            if let changePercent = attributeDict["changePercent"] {
                guard let double = Double(changePercent) else {return}
                tempQuoteAttr.changePercent = double
            }
            quote.quoteAttrs = tempQuoteAttr
            symbol.quote = quote
            symbols.append(symbol)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parsingCompleted()
    }
    
    func parsingCompleted() {
        
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
            print(parseError)
            print("on:", parser.lineNumber, "at:", parser.columnNumber)
    }
}
