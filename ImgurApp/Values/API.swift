//
//  Urls.swift
//  ImgurApp
//
//  Created by Иван Романов on 05.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import Foundation

enum Urls {
    static let serverURL = "https://api.imgur.com/3"
    static let personalGalleryURL = serverURL + "/gallery"
    static let hotSortedPersonalGalleryURL = personalGalleryURL + "/hot"
}

enum APIKeys {
    static let clientId = "c2154c0f018adfa"
    
}
