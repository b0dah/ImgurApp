//
//  PostHeaderView.swift
//  ImgurApp
//
//  Created by Иван Романов on 06.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class PostHeaderView: UITableViewHeaderFooterView {

    // MARK:- Subviews
        private let headerBackView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 30)
            label.textColor = .darkText
            label.textAlignment = .left
            label.numberOfLines = 0
            label.text = "sdklfksdlkfsdkflksdlf"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let pictureView: UIImageView = {
            let pictureView = UIImageView()
            pictureView.contentMode = .scaleAspectFit
            pictureView.translatesAutoresizingMaskIntoConstraints = false
    //        pictureView.clipsToBounds = false
            return pictureView
        }()
        
        private let commentsHeaderBackView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        private let commentsHeaderLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 18)
            label.textColor = .systemGray
            label.textAlignment = .center
            label.text = "Comments:"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    // MARK:- Lifecycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .blue
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Private Methods
    private func setupViews() {}
    
    private func makeLayout() {

        // Title Label Constraints
        headerBackView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: headerBackView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: headerBackView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: headerBackView.trailingAnchor, constant: -10).isActive = true
        
        // Post Picture View Constraints
        headerBackView.addSubview(pictureView)
        pictureView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        pictureView.leadingAnchor.constraint(equalTo: headerBackView.leadingAnchor).isActive = true
        pictureView.trailingAnchor.constraint(equalTo: headerBackView.trailingAnchor).isActive = true
        
        pictureView.bottomAnchor.constraint(equalTo: headerBackView.bottomAnchor, constant: -20).isActive = true
        
        // Comments Section BackView View Constraints
        headerBackView.addSubview(commentsHeaderBackView)
        commentsHeaderBackView.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 10).isActive = true
        commentsHeaderBackView.leadingAnchor.constraint(equalTo: headerBackView.leadingAnchor).isActive = true
        commentsHeaderBackView.trailingAnchor.constraint(equalTo: headerBackView.trailingAnchor).isActive = true
        commentsHeaderBackView.bottomAnchor.constraint(equalTo: headerBackView.bottomAnchor).isActive = true
        
        // Comments Section Label Constraints
        commentsHeaderBackView.addSubview(commentsHeaderLabel)
        commentsHeaderLabel.topAnchor.constraint(equalTo: commentsHeaderBackView.topAnchor, constant: 20).isActive = true
        commentsHeaderLabel.leadingAnchor.constraint(equalTo: commentsHeaderBackView.leadingAnchor, constant: 10).isActive = true
        commentsHeaderLabel.trailingAnchor.constraint(equalTo: commentsHeaderBackView.trailingAnchor, constant: -10).isActive = true
        commentsHeaderLabel.bottomAnchor.constraint(equalTo: commentsHeaderBackView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK:- Public Methods
    public func updateInfo(title: String, image: Data?) {
        self.titleLabel.text = title
        
        if let image = image {
            self.pictureView.image = UIImage(data: image)
        }
    }
    
}
