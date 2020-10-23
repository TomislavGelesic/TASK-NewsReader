//
//  SingleNewsTitleCell.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 23/10/2020.
//

import UIKit

class SingleNewsTitleCell: UITableViewCell {
    
    let titleContainer: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
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
        self.addSubview(titleContainer)
        
        NSLayoutConstraint.activate([
            titleContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20),
            titleContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20)
        ])
    }
}
