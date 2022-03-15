//
//  DateExtension.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 15.3.22..
//

import Foundation


extension Date {
    func toString() -> String {
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"
        return convertDateFormatter.string(from: self)
    }
}
