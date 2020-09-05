//
//  Comment.swift
//  ImgurApp
//
//  Created by Иван Романов on 04.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation

class Comment {
    var author: String
    var text: String
    
    init(author: String, text: String) {
        self.author = author
        self.text = text
    }
}
