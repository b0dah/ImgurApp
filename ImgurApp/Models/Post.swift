//
//  Post.swift
//  ImgurApp
//
//  Created by Иван Романов on 05.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation
import UIKit

class Post: Codable {
    var id: String
    var title: String
    var images: [Image]?
    var comments: [Comment]?

    init(id: String, title: String, images: [Image]) {
        self.id = id
        self.title = title
        self.images = images
    }
}

class Image: Codable {
    var id: String
    var link: String
    
    init(id: String, link: String) {
        self.id = id
        self.link = link
    }
}
