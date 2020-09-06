//
//  DetailsViewController.swift
//  ImgurApp
//
//  Created by Иван Романов on 04.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

private let commentCellIdentifier = "CommentCell"
private let postHeaderViewIdentifier = "PostHeaderView"

class DetailsViewController: UITableViewController {
    
    // MARK:- Properties
    var post: Post? {
        didSet {
            guard let post = post else {
                print("Nil post sent")
                return
            }
            
//            titleLabel.text = post.title
//
//            if let image = post.primaryImage {
//                pictureView.image = UIImage(data: image)
//            } else {
//                print("No image passed")
//                post.downloadPrimaryImage {
//                    if let image = post.primaryImage {
//                        print("DOWNLOADED")
//                        self.pictureView.image = UIImage(data: image)
//                    }
//                }
//            }
            
        }
    }
    
    
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register the cell
        tableView.register(CommentCell.self, forCellReuseIdentifier: commentCellIdentifier)
        // register the header view
        self.tableView.register(PostHeaderView.self, forHeaderFooterViewReuseIdentifier: postHeaderViewIdentifier)
        
        // get rid of Large Navigation Bar
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // MARK: - Data Request
        if let postId = post?.id {
            ImgurAPIHandler.shared.fetchComments(for: postId) { (fetchedComments) in
                if let comments = fetchedComments {
                    self.post?.comments = comments
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK:- Private Methods
    private func setupCustomHeaderView() {
        
    }
}

// MARK: - UITableViewDataSource
extension DetailsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath) as! CommentCell
        cell.comment = post?.comments?[indexPath.row] ?? nil
        return cell
    }
}

// MARK:- Post Body with Custom Header Layout
extension DetailsViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: postHeaderViewIdentifier) as? PostHeaderView else {
            print("Wrong Header")
            return nil
        }
        
        if let post = post {
            header.updateInfo(title: post.title, image: post.primaryImage)
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
}


