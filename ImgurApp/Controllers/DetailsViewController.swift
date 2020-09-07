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
private let postCellIdentifier = "PostHeaderView"

class DetailsViewController: UITableViewController {
    
    // MARK:- Properties
    var post: Post?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Post"

        // register the cells
        tableView.register(CommentCell.self, forCellReuseIdentifier: commentCellIdentifier)
        tableView.register(PostCell.self, forCellReuseIdentifier: postCellIdentifier)
        
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
}

// MARK: - UITableViewDataSource
extension DetailsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return post?.comments?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: postCellIdentifier, for: indexPath) as! PostCell
            if let post = self.post {
                cell.updateInfo(title: post.title, image: post.primaryImage)
            }
            cell.layoutMargins = UIEdgeInsets.zero
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath) as! CommentCell
            cell.comment = post?.comments?[indexPath.row] ?? nil
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
}


