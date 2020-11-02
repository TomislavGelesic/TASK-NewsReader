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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
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
        fetchData(spinnerOn: true) {
            self.tableView.reloadData()
            self.pullToRefreshControl.endRefreshing()
            self.hideSpinner()
        }
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
    private func fetchData(spinnerOn: Bool, completion: @escaping ()->()) {
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
                        self.articles = json.articles
                        DispatchQueue.main.async {
                            completion()
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
        fetchData(spinnerOn: false){
            self.tableView.reloadData()
            self.pullToRefreshControl.endRefreshing()
        }
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
        let cell: NewsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singleNews = SingleNewsViewController(article: articles[indexPath.row])
        singleNews.title = articles[indexPath.row].title
        navigationController?.pushViewController(singleNews, animated: true)
    }
    
    //MARK: Private Functions
    
    private func setupTableView(){
        view.addSubview(tableView)
        
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
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


