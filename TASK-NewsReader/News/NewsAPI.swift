//
//  Model.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit

class NewsAPI: Decodable {
    var sortBy: String
    var source: String
    var status: String
    var articles: [Article]
    
    struct Article: Decodable {
        var urlToImage: String
        var title: String
        var description: String
    }
    
    init(sortBy: String, source: String, status: String, articles: [Article]) {
        self.sortBy = sortBy
        self.source = source
        self.status = status
        self.articles = articles
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
