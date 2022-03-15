//
//  DataService.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//


import Foundation

class DataService {
    static let shared = DataService()
    
    private init() { }
    
    // Let's just hardcode these values here
    private let symbolUrl = URL(string: "https://www.teletrader.rs/downloads/tt_symbol_list.xml")!
    private let newsArticlesUrl = URL(string: "https://www.teletrader.rs/downloads/tt_news_list.xml")!
    private let userName = "android_tt"
    private let password = "Sk3M!@p9e"
    
    
    private var didFetchSymbolsFromEndpoint = false
    private var symbols = [Symbol]()
    
    private func getData(_ url: URL, _ completion: @escaping (Data) -> ()) {
        var request = URLRequest(url: url)
        request.setBasicAuth(username: userName, password: password)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(data)
            } else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
    
    func getSymbols(_ completion: @escaping ([Symbol]) -> ()){
        // We will fetch data from the endpoint only once - afterwards we will save that array and randomize it's data with every call, so we can simulate price changes
        if didFetchSymbolsFromEndpoint {
            symbols = symbols.map({ symbol in
                var newValueSymbol = symbol
                newValueSymbol.quote?.randomizeValues()
                return newValueSymbol
            })
            completion(symbols)
            return
        }
        getData(symbolUrl) { data in
            let parser = SymbolsParser(data: data)
            if parser.parse() {
                self.symbols = parser.getSymbols()
                self.didFetchSymbolsFromEndpoint = true
                completion(self.symbols)
            } else {
                if let error = parser.parserError {
                    print(error)
                } else {
                    print("Failed while parsing symbols")
                }
            }
        }
    }
    
    func getNewsArticles(_ completion: @escaping ([NewsArticle]) -> ()){
        getData(newsArticlesUrl) { data in
            let parser = NewsArticlesParser(data: data)
            if parser.parse() {
                completion(parser.getNewsArticles())
            } else {
                if let error = parser.parserError {
                    print(error)
                } else {
                    print("Failed while parsing news articles")
                }
            }
        }
    }
}
