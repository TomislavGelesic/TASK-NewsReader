//
//  ViewController.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit


class NewsViewController: UIViewController {
    
    //MARK: Properties
    
    var articles = [Article]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let pullToRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return control
    }()
    
    
    //MARK: Life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViewController()
        
        setupPullToRefreshControl()
        fetchData(spinnerOn: true)
    }
}

extension NewsViewController {
    //MARK: Functions
    
    private func setupViewController(){
        navigationItem.title = "News reader"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .blue
        view.backgroundColor = .white
    }
    
    private func setupPullToRefreshControl() {
        tableView.addSubview(pullToRefreshControl)
        pullToRefreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    //MARK: fetchData
    private func fetchData(spinnerOn: Bool) {
        guard let url = URL(string: Constants.API.BASE_URL + Constants.API.API_KEY_2) else { return }
        
        if spinnerOn {
            showSpinner()
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.showAPIFailAlert()
                print(error)
            }
            else {
                if let data = data {
                    do{
                        let json = try JSONDecoder().decode(News.self, from: data)
                        self.articles.removeAll()
                        for article in json.articles{
                            self.articles.append(article)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.pullToRefreshControl.endRefreshing()
                            self.hideSpinner()
                        }
                    } catch {
                        print("Error parsing JSON")
                    }
                }
            }
        }.resume()
    }
    
    @objc func refreshNews() {
        print("Retrieving update on news...")
        fetchData(spinnerOn: false)
    }
    
    
    private func showAPIFailAlert(){
        let alert = UIAlertController(title: "Error", message: "Ups, error occured!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        DispatchQueue.main.async {
            self.hideSpinner()
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: TableView Setup
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL.MULTI_CELL_ID, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        fillCell(cell: cell, from: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singleNews = SingleNewsViewController(article: articles[indexPath.row])
        singleNews.title = articles[indexPath.row].title
        singleNews.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(singleNews, animated: true)
    }
    
    //MARK: Private Functions
    private func fillCell(cell: NewsTableViewCell,from article: Article) {
        cell.imageViewCell.image = UIImage(url: URL(string: article.urlToImage))
        cell.titleLabelCell.text = article.title
        cell.contentLabelCell.text = article.description
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: Constants.CELL.MULTI_CELL_ID)
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
}


