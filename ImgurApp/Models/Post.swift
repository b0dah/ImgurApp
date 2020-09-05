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
    var id: String
    var title: String
    var image: UIImage?

    init(id: String, title: String, image: UIImage) {
        self.id = id
        self.title = title
        self.image = image
    }
}
