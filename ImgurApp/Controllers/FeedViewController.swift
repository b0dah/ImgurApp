//
//  FeedViewController.swift
//  ImgurApp
//
//  Created by Иван Романов on 04.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

private let cellIdentifier = "FeedCell"

class FeedViewController: UICollectionViewController {
    
    // MARK:- Properties
    var posts: [Post] = [Post(id: "1", title: "Title", images: [Image(id: "", link: "")]),
                         Post(id: "1", title: "Title", images: [Image(id: "", link: "")]),
                         Post(id: "1", title: "Title", images: [Image(id: "", link: "")]),
                         Post(id: "1", title: "Title", images: [Image(id: "", link: "")])]
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        // Navigation Bar Setup
        navigationItem.title = "Feed"
        UINavigationBar.appearance().barTintColor = UIColor.white   // 1
        
        // request
        ImgurAPIHandler.shared.fetchPostsGallery {
            (posts) in
            if let posts = posts {
                self.posts = posts
                self.collectionView.reloadData()
            }
        }
    }
    
    
}

// MARK:- UICollectionViewDataSource
extension FeedViewController {
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FeedCell
        cell.title = posts[indexPath.row].title
        return cell
    }
}


// MARK:- UICollectionViewDelegate
extension FeedViewController {
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController()
        let post = posts[indexPath.row]
        detailsViewController.post = post
        navigationController?.pushViewController(detailsViewController, animated: true)
//        self.present(detailsViewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewFlowLayout Methods
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 1) / 2
        // square cell
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

// MARK:- Pass Post Data within a Segue
extension FeedViewController {
    
    
}

