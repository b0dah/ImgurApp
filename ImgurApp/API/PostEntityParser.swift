//
//  PostEntityParser.swift
//  ImgurApp
//
//  Created by Иван Романов on 05.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

extension FeedViewController {
    
    private func parsePostEntity(with dictionary: [String: AnyObject] ) -> [Post]? {
        guard let jsonArray = dictionary["data"] as? [[String: AnyObject]] else {
            print("Can't parse data object")
            return nil
        }
        
        let postsArray: [Post] = jsonArray.compactMap { postObject in
            guard
                let id = postObject["id"] as? String,
                let title = postObject["title"] as? String,
                let imagesArray = postObject["images"] as? [Image],
                let primaryImageUrl = imagesArray.first?.link
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
