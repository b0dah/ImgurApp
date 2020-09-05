//
//  CommentCell.swift
//  ImgurApp
//
//  Created by Иван Романов on 04.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {
    
    // MARK: - Properties
    var comment: Comment? {
        didSet {
            authorLabel.text = comment?.author
            bodyTextLabel.text = comment?.text
        }
    }
    
    // MARK: - Subviews
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    let bodyTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Author Label constraints
        addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true

        // Body Label constraints
        addSubview(bodyTextLabel)
        bodyTextLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10).isActive = true
        bodyTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        bodyTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        bodyTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
