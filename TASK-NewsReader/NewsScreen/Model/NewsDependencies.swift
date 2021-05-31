//
//  NewsDependencies.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 31.05.2021..
//

import UIKit

struct NewsDependencies {
    var dataSource: UITableViewDiffableDataSource<Section, NewsRowItem>?
    var repository: NewsRepository
    
    init(repository: NewsRepository, dataSource: UITableViewDiffableDataSource<Section, NewsRowItem>? = nil) {
        self.repository = repository
    }
}
