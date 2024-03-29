//
//  ResultScreenViewController.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit



class SingleNewsViewController: UIViewController {
    
    //MARK: Properties
    var screenData: [RowData]
    
    var article: Article
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: init
    init(article: Article) {
        self.article = article
        self.screenData = [RowData]()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViewController()
        
        setupTableView()
        screenData = createRowData(from: article)
        tableView.reloadData()
    }
}

//MARK: Functions
extension SingleNewsViewController {
    
    private func setupViewController(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .blue
        view.backgroundColor = .white
        title = article.title
    }
    
    private func createRowData(from article: Article) -> [RowData] {
        var row = [RowData]()
        row.append(RowData.init(type: .image, string: article.urlToImage))
        row.append(RowData.init(type: .title, string: article.title))
        row.append(RowData.init(type: .content, string: article.description))
        return row
    }
}

//MARK: TableView
extension SingleNewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView () {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SingleNewsImageCell.self, forCellReuseIdentifier: SingleNewsImageCell.reuseIdentifier)
        tableView.register(SingleNewsTitleCell.self, forCellReuseIdentifier: SingleNewsTitleCell.reuseIdentifier)
        tableView.register(SingleNewsContentCell.self, forCellReuseIdentifier: SingleNewsContentCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        
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
        return screenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = screenData[indexPath.row]
        
        switch item.type {
        case .image:
            let cell: SingleNewsImageCell = tableView.dequeueReusableCell(for: indexPath)
            if let image = UIImage(url: URL(string: item.value)) {
                cell.configure(with: image)
            }
            return cell
        case .title:
            let cell: SingleNewsTitleCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: item.value)
            return cell
        case .content:
            let cell: SingleNewsContentCell = tableView.dequeueReusableCell(for: indexPath)
            cell.configure(with: item.value)
            return cell
        }
    }
    
}
