//
//  StringExtension.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 15.3.22..
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: self) ?? Date()
    }
}
