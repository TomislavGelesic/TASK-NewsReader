//
//  ResultScreenViewController.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit



class SingleNewsViewController: UIViewController {
    
    //MARK: Properties
    var rowData: [RowData]
    
    var article: Article
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: init
    init(article: Article) {
        self.article = article
        self.rowData = [RowData]()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViewController()
        
        setupTableView()
        rowData = createRowData(from: article)
        tableView.reloadData()
    }
}

//MARK: Functions
extension SingleNewsViewController {
    
    private func setupViewController(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .blue
        view.backgroundColor = .white
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
        
        tableView.register(SingleNewsImageCell.self, forCellReuseIdentifier: "SingleNewsImageCell")
        tableView.register(SingleNewsTitleCell.self, forCellReuseIdentifier: "SingleNewsTitleCell")
        tableView.register(SingleNewsContentCell.self, forCellReuseIdentifier: "SingleNewsContentCell")
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
        return rowData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = rowData[indexPath.row]
        
        switch item.type {
        case .image:
            let cell: SingleNewsImageCell = tableView.dequeueReusableCell(for: indexPath)
            cell.imageContainer.image = UIImage(url: URL(string: item.value))
            return cell
        case .title:
            let cell: SingleNewsTitleCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleContainer.text = item.value
            return cell
        case .content:
            let cell: SingleNewsContentCell = tableView.dequeueReusableCell(for: indexPath)
            cell.contentContainer.text = item.value
            return cell
        }
    }
    
}
