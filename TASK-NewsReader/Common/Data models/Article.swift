//
//  Article.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 26/10/2020.
//

import UIKit

class Article: Codable, Hashable {
    var identifier = UUID()
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
    
    private enum CodingKeys: String, CodingKey {
        case urlToImage
        case title
        case description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}


