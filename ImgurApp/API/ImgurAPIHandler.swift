//
//  ImgurAPIHandler.swift
//  ImgurApp
//
//  Created by Иван Романов on 05.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class ImgurAPIHandler {
    
    static let shared = ImgurAPIHandler()
    private init() {}
    
    // MARK:- Public Properties
    public var isPaginating = false
    
    // MARK:- Public Methods
    public func fetchPostsGallery(pagination: Bool = false, pageNumber: Int, _ completion: @escaping (Result<[Post]?>)->() ) {
        
        if pagination {
            isPaginating = true
        }
        
        let parameters : [String: String] = ["page": "\(pageNumber)"]
        
        guard let url = URL(string: Urls.hotSortedPersonalGalleryURL)?.withQueries(parameters) else {
            DispatchQueue.main.async {
                completion(Result.error(Error.unknownAPIResponse))
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(APIKeys.clientId)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(Result.error(error as! Error))
                    self.isPaginating = false
                }
                return
            }
            
            guard let data = data, response != nil else {
                print("Error Occured")
                DispatchQueue.main.async {
                    completion(Result.error(Error.unknownAPIResponse))
                    self.isPaginating = false
                }
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                    if let postsArray = Post.parsePostEntity(with: json) {
                        
                        DispatchQueue.main.async {
                            completion(Result.results(postsArray))
                            self.isPaginating = false
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    public func fetchComments(for postId: String, completion: @escaping (Result<[Comment]?>)->()) {
        
        let parameters = ["commentSort": "top"]
        
        guard let url = URL(string: "\(Urls.personalGalleryURL)/\(postId)/comments/")?.withQueries(parameters) else {
                DispatchQueue.main.async {
                    completion(Result.error(Error.unknownAPIResponse))
                }
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(APIKeys.clientId)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, response != nil else {
                print("Comments weren't received!")
                DispatchQueue.main.async {
                    completion(Result.error(Error.unknownAPIResponse))
                }
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                    
                    DispatchQueue.main.async {
                        if let commentsArray = Comment.parseCommentsEntity(with: json) {
                            completion(Result.results(commentsArray))
                        }
                    }
                }
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(Result.error(error as! Error))
                }
            }
        }.resume()
    }
}
