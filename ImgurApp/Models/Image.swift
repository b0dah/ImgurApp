//
//  Image.swift
//  ImgurApp
//
//  Created by Иван Романов on 05.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation

class Image: Codable {
    var id: String
    var link: String
    var type: String
    
    init(id: String, link: String, type: String) {
        self.id = id
        self.link = link
        self.type = type
    }
}
