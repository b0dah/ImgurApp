//
//  DetailsViewController.swift
//  ImgurApp
//
//  Created by Иван Романов on 04.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

private let commentCellIdentifier = "CommentCell"

class DetailsViewController: UITableViewController {
    
    // MARK:- Properties
    var post: Post? {
        didSet {
            guard let post = post else {
                print("Nil post sent")
                return
            }
            
            titleLabel.text = post.title
            if let image = post.image {
                pictureView.image = image
            }
        }
    }
    
    let comments = [Comment(author: "dksl", text: "dso"),
                    Comment(author: "dksl", text: "dso"),
                    Comment(author: "dksl", text: "dso")]
    
    // MARK:- Subviews
    private let headerBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pictureView: UIImageView = {
        let pictureView = UIImageView()
        pictureView.contentMode = .scaleAspectFit
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
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.text = "Comments:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register the cell
        tableView.register(CommentCell.self, forCellReuseIdentifier: commentCellIdentifier)
        
        // get rid of Large Navigation Bar
        navigationController?.navigationBar.prefersLargeTitles = false

    }
    
    // MARK:- Private Methods
    private func setupCustomHeaderView() {
        
        // Title Label Constraints
        headerBackView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: headerBackView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: headerBackView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: headerBackView.trailingAnchor, constant: 10).isActive = true
        
        // Post Picture View Constraints
        headerBackView.addSubview(pictureView)
        pictureView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        pictureView.leadingAnchor.constraint(equalTo: headerBackView.leadingAnchor).isActive = true
        pictureView.trailingAnchor.constraint(equalTo: headerBackView.trailingAnchor).isActive = true
        
        // Comments Section Label Back View Constraints
        headerBackView.addSubview(commentsHeaderBackView)
        commentsHeaderBackView.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 10).isActive = true
        commentsHeaderBackView.leadingAnchor.constraint(equalTo: headerBackView.leadingAnchor).isActive = true
        commentsHeaderBackView.trailingAnchor.constraint(equalTo: headerBackView.trailingAnchor).isActive = true
        commentsHeaderBackView.bottomAnchor.constraint(equalTo: headerBackView.bottomAnchor, constant: 10).isActive = true
        
        // Comments Section Label Constraints
        commentsHeaderBackView.addSubview(commentsHeaderLabel)
        commentsHeaderLabel.topAnchor.constraint(equalTo: commentsHeaderBackView.topAnchor, constant: 10).isActive = true
        commentsHeaderLabel.leadingAnchor.constraint(equalTo: commentsHeaderBackView.leadingAnchor, constant: 20).isActive = true
        commentsHeaderLabel.trailingAnchor.constraint(equalTo: commentsHeaderBackView.trailingAnchor, constant: 20).isActive = true
        commentsHeaderLabel.bottomAnchor.constraint(equalTo: commentsHeaderBackView.bottomAnchor, constant: -10).isActive = true
    }
}

// MARK: - UITableViewDataSource
extension DetailsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath) as! CommentCell
        cell.comment = comments[indexPath.row]
        return cell
    }
}

// MARK:- Post Body with Custom Header Layout
extension DetailsViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        setupCustomHeaderView()
        return headerBackView
    }
}
