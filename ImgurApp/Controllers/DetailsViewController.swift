//
//  DetailsViewController.swift
//  ImgurApp
//
//  Created by Иван Романов on 04.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

// MARK:- Identifiers
private let commentCellIdentifier = "CommentCell"
private let postHeaderViewIdentifier = "PostHeaderView"
private let postCellIdentifier = "PostHeaderView"

class DetailsViewController: UITableViewController {
    
    // MARK:- Properties
    var post: Post?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.registerIdentifiers()
        
        // MARK: - Data Request
        self.initialDataRequest()
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
        case 0: // Post Body Section
            return 1
        case 1: // Comments Section
            return post?.comments?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        
        case 0: // Post Body Section
            let cell = tableView.dequeueReusableCell(withIdentifier: postCellIdentifier, for: indexPath) as! PostCell
            if let post = self.post {
                cell.updateInfo(title: post.title, image: post.primaryImage)
            }
            cell.layoutMargins = UIEdgeInsets.zero
            return cell
        
        case 1: // Comments Section
            let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath) as! CommentCell
            cell.comment = post?.comments?[indexPath.row] ?? nil
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
}

extension DetailsViewController {
// MARK:- UI Setup
    private func setupNavigationBar() {
        self.title = "Post"
        // get rid of Large Navigation Bar
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func registerIdentifiers() {
        // register the cells
        tableView.register(CommentCell.self, forCellReuseIdentifier: commentCellIdentifier)
        tableView.register(PostCell.self, forCellReuseIdentifier: postCellIdentifier)
    }
}

extension DetailsViewController {
    private func initialDataRequest() {
        if let postId = post?.id {
               ImgurAPIHandler.shared.fetchComments(for: postId) { (result) in
                   
                   switch result {
                   case .error(let error):
                       print("Error: \(error)")
                   case .results(let newlyDownloadedComments):
                       if let comments = newlyDownloadedComments {
                           self.post?.comments = comments
                           self.tableView.reloadData()
                       }
                   }
               }
           }
    }
}




