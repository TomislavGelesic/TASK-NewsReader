//
//  Model.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit

class News: Decodable {
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


class Article: Decodable {
    var urlToImage: String
    var title: String
    var description: String
    
    init(urlToImage: String, title: String, description: String){
        self.urlToImage = urlToImage
        self.title = title
        self.description = description
    }
    
    required init?(coder: NSCoder) {
        fatalError("Article init(coder:) has not been implemented")
    }
}
