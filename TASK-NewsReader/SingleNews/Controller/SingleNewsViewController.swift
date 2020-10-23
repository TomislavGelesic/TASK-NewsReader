//
//  ResultScreenViewController.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit



class SingleNewsViewController: UIViewController {
    
    //MARK: Properties
    var data: [SingleNewsData]
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: init
    init(article: Article) {
        data = [SingleNewsData]()
        data.append(SingleNewsData(type: .image, string: article.urlToImage))
        data.append(SingleNewsData(type: .title, string: article.title))
        data.append(SingleNewsData(type: .content, string: article.description))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViewController()
        setupTableView()
        
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
    
}

//MARK: TableView
extension SingleNewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView () {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SingleNewsImageCell.self, forCellReuseIdentifier: CELL.IMAGE_CELL_ID)
        tableView.register(SingleNewsTitleCell.self, forCellReuseIdentifier: CELL.TITLE_CELL_ID)
        tableView.register(SingleNewsContentCell.self, forCellReuseIdentifier: CELL.CONTENT_CELL_ID)
        
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let datum = data[indexPath.row]
        switch datum.item.type {
        case .image:
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: CELL.IMAGE_CELL_ID, for: indexPath) as? SingleNewsImageCell  else { fatalError("ERROR tableView.dequeueReusableCell(withIdentifier: CELL.IMAGE_CELL_ID, for: indexPath) as? SingleNewsImageCell ")}
            imageCell.imageContainer.image = UIImage(url: URL(string: datum.item.value))
            return imageCell
        case .title:
            guard let titleCell = tableView.dequeueReusableCell(withIdentifier: CELL.TITLE_CELL_ID, for: indexPath) as? SingleNewsTitleCell  else { fatalError("ERROR tableView.dequeueReusableCell(withIdentifier: CELL.TITLE_CELL_ID, for: indexPath) as? SingleNewsTitleCell ")}
            titleCell.titleContainer.text = datum.item.value
            return titleCell
        case .content:
            guard let contentCell = tableView.dequeueReusableCell(withIdentifier: CELL.CONTENT_CELL_ID, for: indexPath) as? SingleNewsContentCell  else { fatalError("ERROR tableView.dequeueReusableCell(withIdentifier: CELL.CONTENT_CELL_ID, for: indexPath) as? SingleNewsContentCell ")}
            contentCell.contentContainer.text = datum.item.value
            return contentCell
            
        }
    }
    
}
