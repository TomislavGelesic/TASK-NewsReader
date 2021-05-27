//
//  NewsRepository.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 27.05.2021..
//

import Foundation
import Combine

protocol NewsRepository {
    func getNewsList() -> AnyPublisher<Result<News, ErrorType>, Never>
}
