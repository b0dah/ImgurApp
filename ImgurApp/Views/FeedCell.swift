//
//  FeedCellCollectionViewCell.swift
//  ImgurApp
//
//  Created by Иван Романов on 04.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    // MARK:- Properties
    var image: UIImage? {
        didSet {
            guard let image = image else {
                print("No image passed")
                return
            }
            pictureView.image = image
        }
    }
    
    var title: String? {
        didSet {
            guard let title = title else {
                print("No title passed for the post")
                return
            }
            titleLabel.text = title
        }
    }
    
    // MARK: - Subviews
    private let pictureView: UIImageView = {
        let pictureView = UIImageView()
        // image placeholder
        pictureView.image = #imageLiteral(resourceName: "image-placeholder-vertical")
        pictureView.contentMode = .scaleToFill//.scaleAspectFit
        pictureView.translatesAutoresizingMaskIntoConstraints = false
//        pictureView.clipsToBounds = true
        return pictureView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 5.0
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK:- lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(pictureView)
        pictureView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pictureView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pictureView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        pictureView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true

        pictureView.addSubview(titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: pictureView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
