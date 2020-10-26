//
//  Article.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 26/10/2020.
//

import UIKit

class Article: Codable {
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


