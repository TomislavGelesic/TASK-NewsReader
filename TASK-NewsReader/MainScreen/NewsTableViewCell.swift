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
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabelCell: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textStackCell: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        addSubview(textStackCell)
        
        textStackCell.addArrangedSubview(titleLabelCell)
        textStackCell.addArrangedSubview(descriptionLabelCell)
        
        
        setConstraints()
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            imageViewCell.topAnchor.constraint(equalTo: self.topAnchor),
            imageViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageViewCell.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        
        NSLayoutConstraint.activate([
            textStackCell.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textStackCell.leadingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: 5),
            textStackCell.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
}


