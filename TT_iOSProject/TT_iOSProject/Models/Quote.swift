//
//  Quote.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import Foundation

struct Quote {
    var last: Double
    let low: Double
    let high: Double
    let dateTime: Date
    let bid: Double?
    let ask: Double?
    let volume: Int?
    var change: Double?
    var changePercent: Double?
    
    
    mutating func randomizeValues() {
        let newLast = Double.random(in: (last * 0.8)...(last * 1.2))
        
        // value pretty much can't drop to 0, but in case that happens we need to be sure that we won't divide with it
        if last < 0 {
            last = .leastNonzeroMagnitude
        }
        
        change = newLast - last
        changePercent = change! / last * 100
        last = newLast
    }
}
