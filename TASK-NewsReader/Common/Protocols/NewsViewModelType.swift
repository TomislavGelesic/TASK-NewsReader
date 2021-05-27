//
//  NewsViewModelOutputType.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 27.05.2021..
//

import Foundation
import Combine


// NewsViewModelOutput <-> AnyPublisher<NewsState, Never>
// NewsViewModelOutput is expandable like Input - in this app code is reduced due to complexity of the app

protocol NewsViewModelType {
    var inputSubject: CurrentValueSubject<NewsViewModelInput, Never> { get set }
    func bindViewModel() -> AnyCancellable
}
