//
//  PostCell.swift
//  ImgurApp
//
//  Created by Иван Романов on 07.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    // MARK:- Subviews
    private let headerBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pictureView: UIImageView = {
        let pictureView = UIImageView()
        pictureView.translatesAutoresizingMaskIntoConstraints = false
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        self.titleLabel.topAnchor.constraint(equalTo: self.headerBackView.topAnchor, constant: 16.0).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.headerBackView.leadingAnchor, constant: 16.0).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.headerBackView.trailingAnchor, constant: -16.0).isActive = true
        
        // Post Picture View Constraints
        self.headerBackView.addSubview(self.pictureView)
        self.pictureView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16.0).isActive = true
        self.pictureView.leadingAnchor.constraint(equalTo: self.headerBackView.leadingAnchor).isActive = true
        self.pictureView.trailingAnchor.constraint(equalTo: self.headerBackView.trailingAnchor).isActive = true
        
        // Comments Section Label Constraints
        self.headerBackView.addSubview(self.commentsHeaderLabel)
        self.commentsHeaderLabel.topAnchor.constraint(equalTo: self.pictureView.bottomAnchor, constant: 16.0).isActive = true
        self.commentsHeaderLabel.leadingAnchor.constraint(equalTo: self.headerBackView.leadingAnchor, constant: 10.0).isActive = true
        self.commentsHeaderLabel.trailingAnchor.constraint(equalTo: self.headerBackView.trailingAnchor, constant: -10.0).isActive = true
        self.commentsHeaderLabel.bottomAnchor.constraint(equalTo: self.headerBackView.bottomAnchor, constant: -16).isActive = true
      
        
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
            guard let image = UIImage(data: image) else {
                print("Couln't convert data into image")
                return
            }
            
            self.pictureView.image = image
            
            // Realtive ImageView Height
            self.pictureView.heightAnchor.constraint(equalToConstant: self.frame.width * image.aspectRatio).isActive = true
            self.pictureView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true

        }
    }
    
}
