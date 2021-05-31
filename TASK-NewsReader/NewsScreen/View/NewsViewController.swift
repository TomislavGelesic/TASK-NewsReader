//
//  ViewController.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
    
    var disposeBag = Set<AnyCancellable>()
    var viewModel: NewsViewModel
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let pullToRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "Refreshing")
        return control
    }()
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSpinner()
        viewModel.appear()
    }
}

extension NewsViewController {
    
    private func configureUI() {
        setupTableView()
        setupAppearance()
        setupPullToRefreshControl()
    }
    private func bindUI() {
        viewModel.createTableViewDataSource(on: tableView)
        viewModel.bindViewModel()
            .store(in: &disposeBag)
        viewModel.outputSubject
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { [unowned self] (output) in self.render(output) }
            .store(in: &disposeBag)
    }
    
    private func render(_ output: NewsViewModelOutput) {
        
        for action in output.actions {
            switch action {
            case .showDetails(let article):
                self.showNewsDetails(for: article)
            case .showEmpty:
//                show empty cell
                showEmptyAlert()
            case .showError:
//                guard let error = output.errorType else { return }
                showAPIFailAlert()
            case .update:
                break
            }
        }
        pullToRefreshControl.endRefreshing()
        hideSpinner()
    }
    private func setupAppearance(){
        navigationItem.title = "News reader"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .blue
        view.backgroundColor = .white
    }
    
    private func setupPullToRefreshControl() {
        tableView.addSubview(pullToRefreshControl)
        pullToRefreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }

    @objc func refreshNews() {
        showSpinner()
        viewModel.refresh()
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableViewConstraints()
    }
    
    private func tableViewConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func showAPIFailAlert() {
        let alert = UIAlertController(title: "Error", message: "Ups, error occured!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        DispatchQueue.main.async {
            self.hideSpinner()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showEmptyAlert() {
        let alert = UIAlertController(title: "No result", message: "Please, try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
        DispatchQueue.main.async {
            self.hideSpinner()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showNewsDetails(for article: Article) {
        let vc = SingleNewsViewController(article: article)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadScreenData() {
        tableView.reloadData()
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showSpinner()
        viewModel.selected(at: indexPath)
    }
}


