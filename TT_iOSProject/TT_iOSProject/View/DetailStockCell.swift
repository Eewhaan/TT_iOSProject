//
//  DetailStockCell.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 26.3.22..
//

import UIKit

class DetailStockCell: UITableViewCell {
    
    func configure(selectedSymbol: Symbol, row: Int) {
        
        guard let quote = selectedSymbol.quote else { return }
        
        switch row {
        case 0:
            self.detailTextLabel?.text = selectedSymbol.name
            self.textLabel?.text = "Name"
        case 1:
            self.detailTextLabel?.text = selectedSymbol.decorativeName
            self.textLabel?.text = "Decorative Name"
        case 2:
            self.detailTextLabel?.text = selectedSymbol.stockExchangeName
            self.textLabel?.text = "Stock Exchange Name"
        case 3:
            self.detailTextLabel?.text = selectedSymbol.currency
            self.textLabel?.text = "Currency"
        case 4:
            self.detailTextLabel?.text = selectedSymbol.tickerSymbol
            self.textLabel?.text = "Ticker Symbol"
        case 5:
            self.detailTextLabel?.text = selectedSymbol.isin
            self.textLabel?.text = "ISIN"
        case 6:
            self.detailTextLabel?.text = String(format: "%.2f", quote.last)
            self.textLabel?.text = "Last"
        case 7:
            self.detailTextLabel?.text = "\(quote.low)"
            self.textLabel?.text = "Low"
        case 8:
            self.detailTextLabel?.text = "\(quote.high)"
            self.textLabel?.text = "High"
        case 9:
            self.detailTextLabel?.text = selectedSymbol.quote?.dateTime.toString()
            self.textLabel?.text = "Date"
        case 10:
            if let bid = quote.bid {
                self.detailTextLabel?.text = "\(bid)"
            } else {
                self.detailTextLabel?.text = "-"
            }
            self.textLabel?.text = "Bid"
        case 11:
            if let ask = quote.ask {
                self.detailTextLabel?.text = "\(ask)"
            } else {
                self.detailTextLabel?.text = "-"
            }
            self.textLabel?.text = "Ask"
        case 12:
            if let volume = quote.volume {
                self.detailTextLabel?.text = "\(volume)"
            } else {
                self.detailTextLabel?.text = "-"
            }
            self.textLabel?.text = "Volume"
        default:
            break
        }
    }
}

class ChangeDetailCell: UITableViewCell {
    
    func configure(selectedSymbol: Symbol, row: Int) {
        
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        guard let number = numberFormat.number(from: String(format: "%.2f", selectedSymbol.quote?.changePercent ?? 1 - 1)) else {return}
        let double = Double(truncating: number)
        
        switch row {
        case 13:
            if double > 0.00 {
                self.detailTextLabel?.textColor = UIColor.systemGreen
            } else if double < 0.00 {
                self.detailTextLabel?.textColor = UIColor.systemRed
            }
            self.detailTextLabel?.text = String(format: "%.2f", selectedSymbol.quote?.change ?? 0)
            self.textLabel?.text = "Change"
        case 14:
            if double > 0.00 {
                self.detailTextLabel?.textColor = UIColor.systemGreen
            } else if double < 0.00 {
                self.detailTextLabel?.textColor = UIColor.systemRed
            }
            self.detailTextLabel?.text = String(format: "%.2f", selectedSymbol.quote?.changePercent ?? 1 - 1)
            self.textLabel?.text = "Change Percent"
        default:
            break
        }
    }
}
