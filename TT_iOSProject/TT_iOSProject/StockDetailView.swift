//
//  StockDetailView.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import UIKit
import WebKit

class StockDetailView: UIViewController {
    var selectedStock = Symbol()
    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = selectedStock.attributes.name
        
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
                    <td>\(selectedStock.attributes.name)</td>
                </tr>
                <tr>
                    <th>Ticker Symbol</th>
                    <td>\(selectedStock.attributes.tickerSymbol)</td>
                </tr>
                <tr>
                    <th>ISIN</th>
                    <td>\(selectedStock.attributes.isin)</td>
                </tr>
                <tr>
                    <th>Currency</th>
                    <td>\(selectedStock.attributes.currency)</td>
                </tr>
                <tr>
                    <th>Stock Exchange Name</th>
                    <td>\(selectedStock.attributes.stockExchangeName)</td>
                </tr>
                <tr>
                    <th>Decorative Name</th>
                    <td>\(selectedStock.attributes.decorativeName)</td>
                </tr>
                <tr>
                    <th>Last</th>
                    <td>\(selectedStock.quote.quoteAttrs.last)</td>
                </tr>
                <tr>
                    <th>High</th>
                    <td>\(selectedStock.quote.quoteAttrs.high)</td>
                </tr>
                <tr>
                    <th>Low</th>
                    <td>\(selectedStock.quote.quoteAttrs.low)</td>
                </tr>
                <tr>
                    <th>Bid</th>
                    <td>\(selectedStock.quote.quoteAttrs.bid)</td>
                </tr>
                <tr>
                    <th>Ask</th>
                    <td>\(selectedStock.quote.quoteAttrs.ask)</td>
                </tr>
                <tr>
                    <th>Volume</th>
                    <td>\(selectedStock.quote.quoteAttrs.volume)</td>
                </tr>
                <tr>
                    <th>Date</th>
                    <td>\(selectedStock.quote.quoteAttrs.dateTime)</td>
                </tr>
                <tr>
                    <th>Change</th>
                    <td>\(selectedStock.quote.quoteAttrs.change)</td>
                </tr>
                <tr>
                    <th>Change Percent</th>
                    <td>\(String(format: "%.2f", selectedStock.quote.quoteAttrs.changePercent - 1))%</td>
                </tr>
            </table>

            </body>
            </html>
            
            """
        webView.loadHTMLString(html, baseURL: nil)
    }
}
