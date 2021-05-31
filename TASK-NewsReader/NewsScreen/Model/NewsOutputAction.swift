//
//  NewsOutputAction.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 27.05.2021..
//

import Foundation

enum NewsOutputAction {
    case update
    case showError(type: ErrorType?)
    case showDetails(for: Article)
    case showEmpty
}
