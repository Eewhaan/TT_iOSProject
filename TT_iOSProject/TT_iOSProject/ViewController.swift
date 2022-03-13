//
//  ViewController.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 13.3.22..
//

import UIKit

class ViewController: UITableViewController {
    
    var symbolList = [Symbol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Hot Stocks"
        
//        let urlString = "https://www.teletrader.rs/downloads/tt_symbol_list.xml"
//        let userName = "android_tt"
//        let password = "Sk3M!@p9e"
        
//        var request = URLRequest(url: URL(string: urlString)!)
//        request.setBasicAuth(username: userName, password: password)
//        request.httpMethod = "POST"
//        guard let url = request.url else { return }
        if let xmlURL = Bundle.main.url(forResource: "tt_symbol_list", withExtension: "xml") {
        if let xmlData = try? Data(contentsOf: xmlURL) {
            let parser = SymbolsParser(data: xmlData)
            if parser.parse() {
                print(parser.symbols[0])
                symbolList = parser.symbols
            } else {
                if let error = parser.parserError {
                    print(error)
                }
            }
        }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symbolList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? StockTableCell else { return UITableViewCell() }
        cell.name.text = symbolList[indexPath.row].attributes.name
        cell.last.text = String (format: "%.2f", symbolList[indexPath.row].quote.quoteAttrs.last)
        let double = (symbolList[indexPath.row].quote.quoteAttrs.changePercent - 1)
        let yourShareString = String(format: "%.2f", double)
        cell.change.text = yourShareString + "%"
        return cell
    }

}
