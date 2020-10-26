//
//  Model.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit

class News: Codable {
    var sortBy: String
    var source: String
    var status: String
    var articles: [Article]
    
    
    init(sortBy: String, source: String, status: String, articles: [Article]) {
        self.sortBy = sortBy
        self.source = source
        self.status = status
        self.articles = articles
    }
    
    required init?(coder: NSCoder) {
        fatalError("News init(coder:) has not been implemented")
    }
}



