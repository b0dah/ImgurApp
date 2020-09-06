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
    
    func fetchPostsGallery(_ completion: @escaping ([Post]?)->() ) {
        
        guard let url = URL(string: Urls.hotSortedPersonalGalleryURL) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(APIKeys.clientId)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, response != nil else {
                print("")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                    
                    DispatchQueue.main.async {
                        if let postsArray = Post.parsePostEntity(with: json) {
                            completion(postsArray)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    public func fetchComments(for postId: String, completion: @escaping ([Comment]?)->()) {
        
        print(postId)
        
        let parameters = ["commentSort": "top"]
        
        guard let url = URL(string: "\(Urls.personalGalleryURL)/\(postId)/comments/")?.withQueries(parameters) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(APIKeys.clientId)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, response != nil else {
                print("Comments weren't received!")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            print(data)
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                    
                    DispatchQueue.main.async {
                        if let commentsArray = Comment.parseCommentsEntity(with: json) {
                            completion(commentsArray)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
