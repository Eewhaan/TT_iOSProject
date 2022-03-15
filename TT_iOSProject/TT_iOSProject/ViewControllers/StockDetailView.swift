//
//  StockDetailView.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import UIKit
import WebKit

class StockDetailView: UIViewController {
    var selectedStock: Symbol?
    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedStock = selectedStock else {
            return
        }
        navigationItem.title = selectedStock.name
        var color: String
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        guard let number = numberFormat.number(from: String(format: "%.2f", selectedStock.quote?.changePercent ?? 1 - 1)) else {return}
        let double = Double(truncating: number)
        if double < 0.00 {
            color = "red"
        } else if double > 0.00 {
            color = "green"
        } else {
            color = "black"
        }
        
        guard
            let last = selectedStock.quote?.last,
            let high = selectedStock.quote?.high,
            let low = selectedStock.quote?.low else {
                    return
                }
        let ask = selectedStock.quote?.ask ?? 0
        let bid = selectedStock.quote?.bid ?? 0
        let volume = selectedStock.quote?.volume ?? 0
        let change = selectedStock.quote?.change ?? 0
        var dateString: String
        if let date = selectedStock.quote?.dateTime {
            dateString = date.toString()
        } else {
            dateString = "-"
        }
        
        




        
        let html = """
            <head>
            <meta name= "viewport" content="width=device-width, initial-scale=1">

            <style>
            img {
                border: 2px solid #555;
                margin: 0px 0 10px 2px;
                border-radius: 10px;
            }
            table {
                font-family: sans-serif;
                font-size: 80%;
                border-collapse: collapse;
                width: 100%;
            }

            td, th {
                
                border: 1px solid #555;
                text-align: left;
                padding: 8px;
            }
            
            tr:hover { background-color: #D6EEEE; }
            
            tr:nth-child(even) {
                background-color: #dddddd;
            }
            </style>
            </head>
            <body>
            <table>
                <tr>
                    <th>Name</th>
                    <td>\(selectedStock.name)</td>
                </tr>
                <tr>
                    <th>Ticker Symbol</th>
                    <td>\(selectedStock.tickerSymbol)</td>
                </tr>
                <tr>
                    <th>ISIN</th>
                    <td>\(selectedStock.isin ?? "-")</td>
                </tr>
                <tr>
                    <th>Currency</th>
                    <td>\(selectedStock.currency)</td>
                </tr>
                <tr>
                    <th>Stock Exchange Name</th>
                    <td>\(selectedStock.stockExchangeName)</td>
                </tr>
                <tr>
                    <th>Decorative Name</th>
                    <td>\(selectedStock.decorativeName)</td>
                </tr>
                <tr>
                    <th>Last</th>
                    <td>\(last)</td>
                </tr>
                <tr>
                    <th>High</th>
                    <td>\(high)</td>
                </tr>
                <tr>
                    <th>Low</th>
                    <td>\(low)</td>
                </tr>
                <tr>
                    <th>Bid</th>
                    <td>\(bid)</td>
                </tr>
                <tr>
                    <th>Ask</th>
                    <td>\(ask)</td>
                </tr>
                <tr>
                    <th>Volume</th>
                    <td>\(volume)</td>
                </tr>
                <tr>
                    <th>Date</th>
                    <td>\(dateString)</td>
                </tr>
                <tr>
                    <th>Change</th>
                    <td style="color:\(color)">\(change)</td>
                </tr>
                <tr>
                    <th>Change Percent</th>
                    <td style="color:\(color)">\(String(format: "%.2f", selectedStock.quote?.changePercent ?? 1 - 1))%</td>
                </tr>
            </table>

            </body>
            </html>
            
            """
        webView.loadHTMLString(html, baseURL: nil)
    }
}
