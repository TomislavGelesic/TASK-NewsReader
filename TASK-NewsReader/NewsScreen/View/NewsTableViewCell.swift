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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let contentLabelCell: GradientOverlayLabel = {
        let label = GradientOverlayLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 12)
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
        contentView.addSubviews(views: [imageViewCell, titleLabelCell, contentLabelCell])
        contentLabelCell.addGradientLayer(frame: self.frame,
                                          colors: [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.withAlphaComponent(0.6).cgColor],
                                          startPoint: CGPoint(x: 0.5, y: 0.4),
                                          endPoint: CGPoint(x: 0.5, y: 1.0),
                                          locations: [0.0, 1.0])
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

