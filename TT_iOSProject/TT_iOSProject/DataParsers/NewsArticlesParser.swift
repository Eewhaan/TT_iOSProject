//
//  NewsArticlesParser.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import Foundation

class NewsArticlesParser: XMLParser {
    private var newsArticles = [NewsArticle]()
    
    private var newsArticle: NewsArticle?
    
    private var headline = String()
    private var imageID = String()
    private var imageSource = String()
    private var elementName = String()
    
    override init(data: Data) {
        super.init(data: data)
        self.delegate = self
    }
    
    func getNewsArticles() -> [NewsArticle] {
        return newsArticles
    }
}

extension NewsArticlesParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == Constants.newsArticleKey {
            newsArticle = NewsArticleMapper.map(attributeDict)
        }  else if elementName == Constants.headlineKey {
            headline = String()
        } else if elementName == Constants.imageIdKey {
            imageID = String()
        } else if elementName == Constants.imageSource {
            imageSource = String()
        }
        
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
            case Constants.newsArticleKey:
                if let newsArticle = newsArticle {
                    newsArticles.append(newsArticle)
                }
            case Constants.headlineKey:
                newsArticle?.headline = headline
            case Constants.imageIdKey:
                newsArticle?.imageID = imageID
            case Constants.imageSource:
                newsArticle?.imageSource = imageSource
            default:
                return
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedCharacters = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        switch elementName {
            case Constants.headlineKey:
                headline += trimmedCharacters
            case Constants.imageIdKey:
                imageID += trimmedCharacters
            case Constants.imageSource:
                imageSource += trimmedCharacters
            default:
                return
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        print("on:", parser.lineNumber, "at:", parser.columnNumber)
    }
}

fileprivate struct Constants {
    static let newsArticleKey = "NewsArticle"
    static let headlineKey = "Headline"
    static let imageIdKey = "ImageID"
    static let imageSource = "ImageSource"
}
