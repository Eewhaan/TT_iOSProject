//
//  URLRequest.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import Foundation

extension URLRequest {
    mutating func setBasicAuth(username: String, password: String) {
        let encodedAuthInfo = String(format: "%@:%@", username, password)
            .data(using: String.Encoding.utf8)!
            .base64EncodedString()
        addValue("Basic \(encodedAuthInfo)", forHTTPHeaderField: "Authorization")
    }
}
