//
//  SingleNewsImageCell.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 23/10/2020.
//

import UIKit

class SingleNewsImageCell: UITableViewCell {
    
    let imageContainer: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        contentView.addSubview(imageContainer)
        
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageContainer.heightAnchor.constraint(equalToConstant: 250),
            imageContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
