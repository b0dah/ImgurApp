//
//  FeedViewController.swift
//  ImgurApp
//
//  Created by Иван Романов on 04.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

// MARK:- Identifiers
private let cellIdentifier = "FeedCell"
private let spinnerFooterReuseIdentifier = "SpinnerFooter"

class FeedViewController: UICollectionViewController {
    
    // MARK:- Properties
    private var posts: [Post] = []
    private var currentPage = 0
    
    // MARK:- Subviews
    private var spinnerFooterView: SpinnerFooterView?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar Setup
        self.setupNavigationController()
        
        // CV Appearence
        self.configureCollectionViewAppearence()
        
        // Views Registering
        self.registerViews()
        
        // initial request
        self.initialDataRequest()
    }
    
}

// MARK:- UICollectionViewDataSource
extension FeedViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    // MARK: Presenting Details View Controller and Data Passing
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController()
        let post = posts[indexPath.row]
        detailsViewController.post = post
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

// MARK:- Pagination Methods
extension FeedViewController {
    
    private func fetchMoreData() {
        if !ImgurAPIHandler.shared.isPaginating {
            
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
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == posts.count - 10 {
            fetchMoreData()
        }
        else if indexPath.row.isMultiple(of: APIValues.imagesPaginationOffset) {
            // image downloading for one more whole screen of content
            self.fetchImagesForPostsWith(startIndex: indexPath.row + APIValues.imagesPaginationOffset) {}
        }
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
    
    
    
}

// MARK:- CollectionView UI
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

// MARK:- Newtwork Call Methods
extension FeedViewController {
    
    // Pagination: Images sequential download
    private func fetchImagesForPostsWith(startIndex: Int, offset: Int = APIValues.imagesPaginationOffset, completion: @escaping ()->()) {
        let group = DispatchGroup()
        
        let boundary = (startIndex + offset < posts.count) ? (startIndex + offset) : posts.count
        guard startIndex <= boundary else { return }
        
        for i in startIndex..<boundary {
            group.enter()
            posts[i].downloadPrimaryImage {
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("Finished all requests.")
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    private func initialDataRequest() {
        ImgurAPIHandler.shared.fetchPostsGallery(pageNumber: 0) { [weak self]
            (postsArray) in
            
            // fetch 1st page json array
            if let posts = postsArray {
                self?.posts.append(contentsOf: posts)
                self?.collectionView.reloadData()
                
                // sequential images preloading
                self?.fetchImagesForPostsWith(startIndex: 0, offset: APIValues.imagesPaginationOffset) {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
}

// MARK:- UI Preparations
extension FeedViewController {
    private func setupNavigationController() {
        navigationItem.title = "Feed ☄️"
        UINavigationBar.appearance().barTintColor = UIColor.white
    }
    
    private func configureCollectionViewAppearence() {
        collectionView.backgroundColor = .white
    }
    
    private func registerViews() {
        // Register cell classes
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        // Register and Setup the Footer
        self.collectionView!.register(SpinnerFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: spinnerFooterReuseIdentifier)
    }
}


