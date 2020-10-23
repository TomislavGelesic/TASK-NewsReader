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
        self.addSubview(imageContainer)
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: self.topAnchor),
            imageContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageContainer.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
