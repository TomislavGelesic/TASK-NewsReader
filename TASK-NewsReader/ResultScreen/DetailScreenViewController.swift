//
//  ResultScreenViewController.swift
//  TASK-NewsReader
//
//  Created by Tomislav Gelesic on 20/10/2020.
//

import UIKit

class DetailScreenViewController: UIViewController {
    //MARK: Properties
    let imageViewDetails: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabelDetails: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textLabelDetails: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: init
    init(title: String, image: UIImage, text: String) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabelDetails.text = title
        self.imageViewDetails.image = image
        self.textLabelDetails.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageViewDetails)
        view.addSubview(titleLabelDetails)
        view.addSubview(textLabelDetails)
        
        setConstraints()
    }
}


extension DetailScreenViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageViewDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageViewDetails.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewDetails.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageViewDetails.heightAnchor.constraint(equalToConstant: view.frame.height/3),
            
            titleLabelDetails.topAnchor.constraint(equalTo: imageViewDetails.bottomAnchor, constant: 10),
            titleLabelDetails.leadingAnchor.constraint(equalTo: imageViewDetails.leadingAnchor, constant: 10),
            titleLabelDetails.trailingAnchor.constraint(equalTo: imageViewDetails.trailingAnchor, constant: -10),
            
            textLabelDetails.topAnchor.constraint(equalTo: titleLabelDetails.bottomAnchor, constant: 15),
            textLabelDetails.leadingAnchor.constraint(equalTo: imageViewDetails.leadingAnchor, constant: 10),
            textLabelDetails.trailingAnchor.constraint(equalTo: imageViewDetails.trailingAnchor, constant: -10),
            
        ])
    }
}
