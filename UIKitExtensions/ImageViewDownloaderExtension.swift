//
//  ImageViewDownloaderExtension.swift
//  ImgurApp
//
//  Created by Иван Романов on 05.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: String) {
            
            guard let url = URL(string: url) else {
                print("Wrong IMAGE URL!")
                return
            }
               
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               guard let data = data, error == nil else {
                   return
               }
                   
    //            print(response?.suggestedFilename!)
                   
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }.resume()
        }
}
