//
//  RestEndpoints.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 27.05.2021..
//

import Foundation

public enum RestEndpoints {
    case news
    
    static let scheme = "https://"
    static let newsHost = "newsapi.org/"
    static let newsPath = "v1/articles?source=bbc-news&sortBy=top&apiKey="
    static let newsAccessKey1 = "d5017336d77b4bd98755d5c62d353a04"
    static let newsAccessKey2 = "89adcdc10bf34345811ec7e66330d4c9"
    
    static var ENDPOINT_NEWS: String {
        return scheme + newsHost + newsPath + newsAccessKey1
    }
    
    public func endpoint() -> String {
        switch self {
        case .news:
            return RestEndpoints.ENDPOINT_NEWS
        }
    }
}

