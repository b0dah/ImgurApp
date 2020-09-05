//
//  Comment.swift
//  ImgurApp
//
//  Created by Иван Романов on 04.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation

class Comment: Codable {
    var author: String
    var text: String
    
    init(author: String, text: String) {
        self.author = author
        self.text = text
    }
    
    // MARK:- Type Methods
    public static func parseCommentsEntity(with dictionary: [String: AnyObject] ) -> [Comment]? {
        guard let jsonArray = dictionary["data"] as? [[String: AnyObject]] else {
            print("Can't parse data object")
            return nil
        }
        
        let commentsArray: [Comment] = jsonArray.compactMap { commentObject in
            guard
                let author = commentObject["author"] as? String,
                let bodyText = commentObject["comment"] as? String
            else {
                print("Can't parse comment object")
                return nil
            }
            
            let eachComment = Comment(author: author, text: bodyText)
            return eachComment
        }
        
        return commentsArray
    }
    
}
