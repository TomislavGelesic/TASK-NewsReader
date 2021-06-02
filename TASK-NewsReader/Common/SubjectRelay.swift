//
//  SubjectRelay.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 02.06.2021..
//

import Foundation
import Combine

class SubjectRelay<ELEMENT, ERROR> where ERROR: Error, ERROR: Equatable {
    
    typealias DATA_TYPE = ELEMENT
    typealias ERROR_TYPE = ERROR
    
    private let subject: CurrentValueSubject<Result<ELEMENT, ERROR>, Never>
    
    init(_ value: ELEMENT) {
        subject = CurrentValueSubject<Result<ELEMENT, ERROR>, Never>(.success(value))
    }
    
    func accept(_ data: DATA_TYPE) {
        subject.send(.success(data))
    }
    func subscribe<ELEMENT> (_ subject: AnyPublisher<ELEMENT, Never>) -> AnyPublisher<Result<DATA_TYPE, ERROR_TYPE>, Never> {
       return subject
        .flatMap { [unowned self] (_) -> AnyPublisher<Result<DATA_TYPE, ERROR_TYPE>, Never> in
            return self.subject.eraseToAnyPublisher()
        }
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    func getPublisher() -> AnyPublisher<Result<DATA_TYPE, ERROR_TYPE>, Never> {
        self.subject.eraseToAnyPublisher()
    }
}
