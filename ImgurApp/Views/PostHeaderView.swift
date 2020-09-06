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
        self.headerBackView.addSubview(self.titleLabel)
        self.titleLabel.topAnchor.constraint(equalTo: self.headerBackView.topAnchor, constant: 10.0).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.headerBackView.leadingAnchor, constant: 10.0).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.headerBackView.trailingAnchor, constant: -10.0).isActive = true
        
        // Comments Section Label Constraints
        self.headerBackView.addSubview(self.commentsHeaderLabel)
        self.commentsHeaderLabel.leadingAnchor.constraint(equalTo: self.headerBackView.leadingAnchor, constant: 10.0).isActive = true
        self.commentsHeaderLabel.trailingAnchor.constraint(equalTo: self.headerBackView.trailingAnchor, constant: -10.0).isActive = true
        self.commentsHeaderLabel.bottomAnchor.constraint(equalTo: self.headerBackView.bottomAnchor, constant: -10).isActive = true
        
        // Post Picture View Constraints
        self.headerBackView.addSubview(self.pictureView)
        self.pictureView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10.0).isActive = true
        self.pictureView.leadingAnchor.constraint(equalTo: self.headerBackView.leadingAnchor, constant: 10.0).isActive = true
        self.pictureView.trailingAnchor.constraint(equalTo: self.headerBackView.trailingAnchor, constant: -10.0).isActive = true
        self.pictureView.bottomAnchor.constraint(equalTo: self.commentsHeaderLabel.topAnchor, constant: -20.0).isActive = true
        
        // Main view
        self.addSubview(self.headerBackView)
        self.headerBackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.headerBackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.headerBackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.headerBackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    // MARK:- Public Methods
    public func updateInfo(title: String, image: Data?) {
        self.titleLabel.text = title
        
        if let image = image {
            self.pictureView.image = UIImage(data: image)
        }
    }
    
}
