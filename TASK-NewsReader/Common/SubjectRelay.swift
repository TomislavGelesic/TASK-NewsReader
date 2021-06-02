//
//  SubjectRelay.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 02.06.2021..
//

import Foundation
import Combine

class SubjectRelay<ELEMENT, ERROR> where ERROR: Error, ERROR: Equatable {
    
    private let subject: CurrentValueSubject<ELEMENT, ERROR>
    
    init(_ subject: CurrentValueSubject<ELEMENT, ERROR>) {
        self.subject = subject
    }
    func accept(_ data: ELEMENT) {
        subject.send(data)
    }
    func getPublisher() -> AnyPublisher<ELEMENT, ERROR> {
        self.subject.eraseToAnyPublisher()
    }
}
