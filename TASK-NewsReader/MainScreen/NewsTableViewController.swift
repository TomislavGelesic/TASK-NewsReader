//
//  ViewController.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit



class NewsTableViewController: UITableViewController {
    
    //MARK: Properties
    let cellId = "cellId"
    let API_KEY_1:String = "d5017336d77b4bd98755d5c62d353a04"
    let API_KEY_2:String = "89adcdc10bf34345811ec7e66330d4c9"
    let BASE_URL: String = "https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey="
    
    var articles = [News.Article]()
    
    var timer: Timer?
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let pullToRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return control
    }()
    
    
    //MARK: Life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTableView()
        setTimerRefreshInterval(interval: 5*60)
        
            fetchData()
    }
    
    //MARK: UITableView OVERRIDES
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NewsTableViewCell else { fatalError("my cell fail") }
        guard let imageUrl = URL(string: articles[indexPath.row].urlToImage) else { fatalError("my cell fail - image url") }
        cell.imageViewCell.image = UIImage(url: imageUrl)
        cell.titleLabelCell.text = articles[indexPath.row].title
        cell.descriptionLabelCell.text = articles[indexPath.row].description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let image = UIImage(url: URL(string: articles[indexPath.row].urlToImage)) {
            let detailScreen = DetailScreenViewController(title: articles[indexPath.row].title,
                                                          image: image,
                                                          text: articles[indexPath.row].description)
            detailScreen.title = self.articles[indexPath.row].title
            detailScreen.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(detailScreen, animated: true)
        }
    }
    
}

//MARK: Functions
extension NewsTableViewController {
    
    private func setup(){
        
        navigationItem.title = "News reader"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = .blue
        
        view.backgroundColor = .white
        view.addSubview(spinner)
        spinnerConstraints()
        
        view.addSubview(pullToRefreshControl)
        pullToRefreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    private func setupTableView(){
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.rowHeight = 80
        
    }
    
    private func setTimerRefreshInterval (interval: Int) {
        self.timer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(refreshNews), userInfo: nil, repeats: true)
    }
    
    private func spinnerConstraints () {
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func fetchData() {
        guard let url = URL(string: BASE_URL + API_KEY_2) else { return }
        
        spinner.startAnimating()
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.showAlert()
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
                            self.spinner.stopAnimating()
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
    
    
    private func showAlert(){
        let alert = UIAlertController(title: "Error", message: "Ups, error occured!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.present(alert, animated: true, completion: nil)
        }
    }
}


// MARK: extension UIImage from URL
extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            self.init(data: try Data(contentsOf: url))
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}
