//
//  NewsViewModel.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 25.05.2021..
//

import UIKit
import Combine

class NewsViewModel: NewsViewModelType {
    
    var outputSubject = CurrentValueSubject<NewsViewModelOutput, Never>(.init(actions: []))
    var inputSubject = CurrentValueSubject<NewsViewModelInput, Never>(.none)
    var disposeBag = Set<AnyCancellable>()
    var dependencies: NewsDependencies
    weak var viewController: NewsViewController?
    
    init(dependencies: NewsDependencies) {
        self.dependencies = dependencies
    }
    
    func bindViewModel() -> AnyCancellable {
        return inputSubject
            .flatMap { [unowned self] (newsInput) -> AnyPublisher<NewsViewModelOutput, Never> in
                switch newsInput {
                case .none:
                    return self.createPublisher(for: .init(actions: [.showEmpty]))
                case .fetchData:
                    return self.fetchNewScreenData()
                case .selected(let indexPath):
                    guard let item = self.dependencies.dataSource?.itemIdentifier(for: indexPath) else { break }
                    return self.createPublisher(for: NewsViewModelOutput(actions: [.showDetails(for: item.value)]))
                }
                return self.createPublisher(for: NewsViewModelOutput(actions: [.showError(type: .recoverable)]))
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { output in
                self.outputSubject.send(output)
            }
    }
    
    func fetchNewScreenData() -> AnyPublisher<NewsViewModelOutput, Never> {
        viewController?.showSpinner()
        return dependencies.repository.getNewsList()
            .flatMap { [unowned self] (response) -> AnyPublisher<NewsViewModelOutput, Never> in
                switch response {
                case .success(let data) where data.articles.isEmpty:
                    return self.createPublisher(for: NewsViewModelOutput(actions: [.showEmpty]))
                case .success(let data):
                    self.updateTableViewDataSource(with: self.createNewsRowItems(from: data))
                    return self.createPublisher(for: NewsViewModelOutput(actions: [.update]))
                case .failure(let error):
                    return self.createPublisher(for: NewsViewModelOutput(actions: [.showError(type: error)]))
                }
            }.eraseToAnyPublisher()
    }
    
    func createPublisher(for output: NewsViewModelOutput) -> AnyPublisher<NewsViewModelOutput, Never> {
        return Just<NewsViewModelOutput>(output).eraseToAnyPublisher()
    }
    
    func createNewsRowItems(from newsResponse: News) -> [NewsRowItem] {
        return newsResponse.articles.map {
            let newArticle = Article(urlToImage: $0.urlToImage, title: $0.title, description: $0.description)
            return NewsRowItem(type: .news, value: newArticle)
        }
    }
    
    func refresh() { inputSubject.send(.fetchData) }    
    func appear() { inputSubject.send(.fetchData) }
    func selected(at indexPath: IndexPath) { inputSubject.send(.selected(indexPath)) }
}

extension NewsViewModel {
    
    typealias TableViewDataSource = UITableViewDiffableDataSource<Section, NewsRowItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, NewsRowItem>
    
    func createTableViewDataSource(on tableView: UITableView) {
        dependencies.dataSource = TableViewDataSource(tableView: tableView) { tableView, indexPath, data in
            let cell: NewsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: data)
            return cell
        }
    }
    func updateTableViewDataSource(with newRowItems: [NewsRowItem]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(newRowItems)
        dependencies.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
