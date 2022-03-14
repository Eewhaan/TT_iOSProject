//
//  NewsArticleMapper.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import Foundation

struct NewsArticleMapper {
    static func map(_ attributeDict: [String : String]) -> NewsArticle? {
        guard
            let id = attributeDict["id"],
            let dateTime = attributeDict["dateTime"],
            let sourceName = attributeDict["sourceName"] else {
                print("NewsArticle mandatory data is missing")
                return nil
            }
        
        return NewsArticle(id: id,
                           dateTime: dateTime,
                           sourceName: sourceName,
                           headline: nil,
                           imageID: nil,
                           imageSource: nil)
    }
}
