//
//  FeedViewController.swift
//  ImgurApp
//
//  Created by Иван Романов on 04.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

private let cellIdentifier = "FeedCell"
private let spinnerFooterReuseIdentifier = "SpinnerFooter"

class FeedViewController: UICollectionViewController {
    
    // MARK:- Properties
    var posts: [Post] = []
    var currentPage = 0
//    var posts: [Post] = [Post(id: "1", title: "Title", images: [Image(id: "", link: "")]),
//                         Post(id: "1", title: "Title", images: [Image(id: "", link: "")]),
//                         Post(id: "1", title: "Title", images: [Image(id: "", link: "")]),
//                         Post(id: "1", title: "Title", images: [Image(id: "", link: "")])]
    
    // MARK:- Subviews
    var spinnerFooterView: SpinnerFooterView?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        // Register cell classes
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        // Register and Setup the Footer
        self.collectionView!.register(SpinnerFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: spinnerFooterReuseIdentifier)
       // Reference size
//        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).footerReferenceSize = CGSize(width: self.view.frame.width, height: 100)
        
        // Navigation Bar Setup
        navigationItem.title = "Feed ☄️"
        UINavigationBar.appearance().barTintColor = UIColor.white   // 1
        
        // request
        ImgurAPIHandler.shared.fetchPostsGallery(pageNumber: 0) { [weak self]
            (postsArray) in
            if let posts = postsArray {
                self?.posts.append(contentsOf: posts)
                self?.collectionView.reloadData()
                
//                self?.fetchImagesForPostsWith(startIndex: 0, offset: APIValues.imagesPaginationOffset * 2) {
//                    self?.collectionView.reloadData()
//                }
            }
        }
        
    }
    
    
}

// MARK:- UICollectionViewDataSource
extension FeedViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FeedCell
        
        // passing data to the cell
        let currentPost = posts[indexPath.row]
        cell.updateUI(title: currentPost.title, imageData: currentPost.primaryImage, imageUrl: currentPost.imageUrl)
        
        return cell
    }
}


// MARK:- UICollectionViewDelegate
extension FeedViewController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: spinnerFooterReuseIdentifier, for: indexPath) as! SpinnerFooterView
            self.spinnerFooterView = view
            return view
        }
        /// Normally should never get here
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if ImgurAPIHandler.shared.isPaginating {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 100)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.spinnerFooterView?.spinner.startAnimating()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.spinnerFooterView?.spinner.stopAnimating()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        if indexPath.row == posts.count - 10,
            !ImgurAPIHandler.shared.isPaginating {
            
            guard currentPage < APIValues.pageLimit else {
                print("Limit reached!")
                return
            }
            
            currentPage += 1
            ImgurAPIHandler.shared.fetchPostsGallery(pagination: true, pageNumber: currentPage) { [weak self]
                (newlyFetchedPosts) in
                if let posts = newlyFetchedPosts {
                    self?.posts.append(contentsOf: posts)
                    self?.collectionView.reloadData()
                }
            }
        } else if indexPath.row.isMultiple(of: APIValues.imagesPaginationOffset) {
            // image downloading for one more whole screen of content
            self.fetchImagesForPostsWith(startIndex: indexPath.row + APIValues.imagesPaginationOffset) {
                //
            }
        }
    }
    
    
    // MARK:- Presenting Details View Controller and Data Passing
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController()
        let post = posts[indexPath.row]
        detailsViewController.post = post
        navigationController?.pushViewController(detailsViewController, animated: true)
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

extension FeedViewController {
    public func fetchImagesForPostsWith(startIndex: Int, offset: Int = APIValues.imagesPaginationOffset, completion: @escaping ()->()) {
        let group = DispatchGroup()
        
        group.enter()
        for i in startIndex..<startIndex + offset {
            posts[i].downloadPrimaryImage {
                group.leave()
            }
            group.wait()
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}


