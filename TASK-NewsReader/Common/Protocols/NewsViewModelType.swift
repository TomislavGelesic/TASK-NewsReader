//
//  NewsViewModelOutputType.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 27.05.2021..
//

import Foundation
import Combine


// NewsViewModelOutput <-> AnyPublisher<NewsState, Never>

protocol NewsViewModelType {
    var inputSubject: SubjectRelay<NewsViewModelInput, Never> { get set }
    func bindViewModel(to viewController: NewsViewController) -> AnyCancellable
}
