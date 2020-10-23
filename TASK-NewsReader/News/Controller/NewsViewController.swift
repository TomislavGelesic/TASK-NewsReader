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
        tableView.rowHeight = 70
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
        fetchData()
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
    
    private func fetchData() {
        guard let url = URL(string: API.BASE_URL + API.API_KEY_2) else { return }
        
        showSpinner()
        
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
        fetchData()
        pullToRefreshControl.endRefreshing()
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
    
    private func setupTableView(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: CELL.MULTI_CELL_ID)
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL.MULTI_CELL_ID, for: indexPath) as? NewsTableViewCell else { fatalError("cellForRowAt failed...") }
        cell.imageViewCell.image = UIImage(url: URL(string: articles[indexPath.row].urlToImage))
        cell.titleLabelCell.text = articles[indexPath.row].title
        cell.descriptionLabelCell.text = articles[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let singleNews = SingleNewsViewController(article: articles[indexPath.row])
            singleNews.title = articles[indexPath.row].title
            singleNews.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(singleNews, animated: true)
        
    }
    
}



