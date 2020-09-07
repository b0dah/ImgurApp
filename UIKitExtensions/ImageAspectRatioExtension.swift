//
//  ImageAspectRatioExtension.swift
//  ImgurApp
//
//  Created by Иван Романов on 07.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

extension UIImage {
    var aspectRatio: CGFloat {
        return self.size.height / self.size.width
    }
}
