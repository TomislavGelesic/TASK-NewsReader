//
//  NewsRepositoryImpl.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 27.05.2021..
//

import Foundation
import Combine

class NewsRepositoryImpl: NewsRepository {
    
    func getNewsList() -> AnyPublisher<Result<News, ErrorType>, Never> {
        let url = RestEndpoints.news.endpoint()
        return RestManager.requestObservable(url: url)
    }
}
