//
//  SymbolsParser.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import Foundation

class SymbolsParser: XMLParser {
    private var symbols = [Symbol]()
    private var symbol: Symbol?
    private var quote: Quote?
    
    override init(data: Data) {
        super.init(data: data)
        self.delegate = self
    }
    
    func getSymbols() -> [Symbol] {
        return symbols
    }
}

extension SymbolsParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == Constants.symbolKey {
            symbol = SymbolMapper.map(attributeDict)
        } else if elementName == Constants.quoteKey {
            quote = QuoteMapper.map(attributeDict)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
            case Constants.symbolKey:
                if let symbol = symbol {
                    symbols.append(symbol)
                }
                symbol = nil
            case Constants.quoteKey:
                symbol?.quote = quote
                quote = nil
            default:
                return
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        print("on:", parser.lineNumber, "at:", parser.columnNumber)
    }
}

fileprivate struct Constants {
    static let symbolKey = "Symbol"
    static let quoteKey = "Quote"
}
