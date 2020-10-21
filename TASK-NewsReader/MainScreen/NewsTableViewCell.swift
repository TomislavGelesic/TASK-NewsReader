//
//  NewsTableViewCell.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit


class NewsTableViewCell: UITableViewCell {
    
    //MARK: Properties
    let imageViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabelCell: UILabel = {
        let label = UILabel ()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    
}

//MARK: Functions
extension NewsTableViewCell {
    
    private func setupViews () {
        addSubview(imageViewCell)
        addSubview(titleLabelCell)
        constraintImage()
        constraintTitle()
    }
    
    private func constraintImage(){
        NSLayoutConstraint.activate([
            imageViewCell.topAnchor.constraint(equalTo: self.topAnchor),
            imageViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageViewCell.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func constraintTitle(){
        NSLayoutConstraint.activate([
            titleLabelCell.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: 10),
            titleLabelCell.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabelCell.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    @objc func cellTapped() {
        
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
