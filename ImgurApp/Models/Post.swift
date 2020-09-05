//
//  Post.swift
//  ImgurApp
//
//  Created by Иван Романов on 05.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation
import UIKit

class Post {
    // Required properties
    var id: String
    var title: String
    var imageUrl: String
    
    // Optional Properties
    var primaryImage: Data?
    var comments: [Comment]?
    
    init(id: String, title: String, imageUrl: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
    }
    
    // MARk:- public Methods
    public func downloadPrimaryImage(with completion: @escaping ()->()) {
        print(imageUrl)
        guard let url = URL(string: imageUrl) else {
            print("Wrong image url!")
            return
        }
            
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
                UIImage(data: data) != nil {
                    DispatchQueue.main.async {
                        self?.primaryImage = data
                        completion()
                    }
            } else {
                DispatchQueue.main.async {
                    print("Couln't convert data into an image")
                }
            }
        }
        
    }
    
    // MARK:- Type Methods
    public static func parsePostEntity(with dictionary: [String: AnyObject] ) -> [Post]? {
          guard let jsonArray = dictionary["data"] as? [[String: AnyObject]] else {
              print("Can't parse data object")
              return nil
          }
          
          let postsArray: [Post] = jsonArray.compactMap { postObject in
              guard
                  let id = postObject["id"] as? String,
                  let title = postObject["title"] as? String,
                let imagesArray = postObject["images"] as? [[String: AnyObject]],
                  let primaryImageUrl = imagesArray.first?["link"] as? String
              else {
                  print("Can't parse post object")
                  return nil
              }
              
              let eachPost = Post(id: id, title: title, imageUrl: primaryImageUrl)
              return eachPost
          }
          
          return postsArray
      }
    
}
