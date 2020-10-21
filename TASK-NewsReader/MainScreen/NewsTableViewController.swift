//
//  ViewController.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var articles = [NewsAPI.Article]()
    
    //MARK: Life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white
        navigationItem.title = "News reader"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = .blue
               
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.rowHeight = 65
        fetchData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? NewsTableViewCell else { fatalError("my cell fail") }
        guard let imageUrl = URL(string: articles[indexPath.row].urlToImage) else { fatalError("my cell fail - image url") }
        cell.imageViewCell.load(url: imageUrl)
        cell.titleLabelCell.text = articles[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailScreen = DetailScreenViewController()
        detailScreen.title = self.articles[indexPath.row].title
//        detailScreen.navigationController?.navigationBar.tintColor = .blue
        self.show(detailScreen, sender: self)
    }
    
}

//MARK: Functions
extension NewsTableViewController {
    
    private func fetchData() {
        guard let url = URL(string: "https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=d5017336d77b4bd98755d5c62d353a04") else { return }
    
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                do{
                    let json = try JSONDecoder().decode(NewsAPI.self, from: data)
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json.articles[0].title)
                    for article in json.articles{
                        self.articles.append(article)
                    }
                } catch {
                    print("im here")
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}

//MARK: NEWS

class News {
    var image: UIImage?
    var title: String?
    
    init() {
        
    }
}
