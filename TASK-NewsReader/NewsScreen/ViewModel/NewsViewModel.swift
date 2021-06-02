//
//  NewsViewModel.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 25.05.2021..
//

import UIKit
import Combine

class NewsViewModel: NewsViewModelType {
    var inputSubject: SubjectRelay<NewsViewModelInput, Never> = .init(.init(.none))
    var repository: NewsRepository
    var disposeBag = Set<AnyCancellable>()
    var screenData = [Article]()
    weak var viewController: NewsViewController?
    
    init(repository: NewsRepository) {
        self.repository = repository
    }
    
    func bindViewModel(to viewController: NewsViewController) -> AnyCancellable {
        return inputSubject
            .getPublisher()
            .flatMap { [unowned self] (newsInput) -> AnyPublisher<NewsViewModelOutput, Never> in
                switch newsInput {
                case .none:
                    return self.createPublisher(for: .init(data: [], actions: [.showEmpty]))
                case .fetchData:
                    return self.fetchNewScreenData()
                case .selected(let position):
                    let article = self.screenData[position]
                    return self.createPublisher(for: .init(data: self.screenData, actions: [.showDetails], detailsPosition: position))
                }
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { (output) in
                viewController.render(output)
            }
    }
    
    func fetchNewScreenData() -> AnyPublisher<NewsViewModelOutput, Never> {
        viewController?.showSpinner()
        return repository.getNewsList()
            .flatMap { [unowned self] (response) -> AnyPublisher<NewsViewModelOutput, Never> in
                switch response {
                case .success(let data) where data.articles.isEmpty:
                    return self.createPublisher(for: NewsViewModelOutput(actions: [.showEmpty]))
                case .success(let data):
                    self.screenData = self.createScreenData(from: data)
                    return self.createPublisher(for: NewsViewModelOutput(data: self.screenData, actions: [.update]))
                case .failure(let error):
                    return self.createPublisher(for: NewsViewModelOutput(actions: [.showError], errorType: error))
                }
            }.eraseToAnyPublisher()
    }
    
    func createPublisher(for output: NewsViewModelOutput) -> AnyPublisher<NewsViewModelOutput, Never> {
        return Just<NewsViewModelOutput>(output).eraseToAnyPublisher()
    }
    
    func createScreenData(from newsResponse: News) -> [Article] {
        return newsResponse.articles.map {
            Article(urlToImage: $0.urlToImage, title: $0.title, description: $0.description)
        }
    }
    
    func refresh() { inputSubject.accept(.fetchData) }
    func appear() { inputSubject.accept(.fetchData) }
    func selected(at position: Int) { inputSubject.accept(.selected(position)) }
}
