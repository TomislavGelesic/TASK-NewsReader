//
//  SingleNewsContentCell.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 23/10/2020.
//

import UIKit

class SingleNewsContentCell: UITableViewCell {
    
    let contentContainer: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
    
    private func setupViews() {
        contentView.addSubview(contentContainer)
        
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}



