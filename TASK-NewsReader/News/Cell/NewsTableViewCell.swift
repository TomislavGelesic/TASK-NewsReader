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
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentLabelCell: VerticalFadeTextUILabel = {
        let label = VerticalFadeTextUILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 12)
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
        contentView.addSubview(imageViewCell)
        contentView.addSubview(titleLabelCell)
        contentView.addSubview(contentLabelCell)
        
        selectionStyle = .none
        
        setConstraints()
    }
    
    private func setConstraints(){

        NSLayoutConstraint.activate([
            imageViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewCell.widthAnchor.constraint(equalToConstant: 100),
            imageViewCell.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabelCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabelCell.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: 5),
            titleLabelCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            contentLabelCell.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: 5),
            contentLabelCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentLabelCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
    }
    
    func configure(with article: Article) {
        imageViewCell.image = UIImage(url: URL(string: article.urlToImage))
        titleLabelCell.text = article.title
        contentLabelCell.text = article.description
    }
    
    
}

