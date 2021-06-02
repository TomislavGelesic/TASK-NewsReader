//
//  NewsSubjectRelay.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 02.06.2021..
//

import Foundation
import Combine

class NewsSubjectRelay: SubjectRelay<[Article], ErrorType> {
    
    
    override func subscribe<ELEMENT> (_ subject: AnyPublisher<ELEMENT, Never>) -> AnyPublisher<Result<DATA_TYPE, ERROR_TYPE>, Never> {
        
    }
}
