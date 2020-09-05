//
//  ImgurAPIHandler.swift
//  ImgurApp
//
//  Created by Иван Романов on 05.09.2020.
//  Copyright © 2020 Иван Романов. All rights reserved.
//

import UIKit

class ImgurAPIHandler {
    
    static let shared = ImgurAPIHandler()
    
    private init() {}
    
    func fetchPostsGallery(_ completion: @escaping ([Post]?)->() ) {
        
        guard let url = URL(string: Urls.hotSortedPersonalGalleryURL) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(APIKeys.clientId)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, response != nil else {
                print("")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] {
                    let jsonArray = json["data"] as? NSArray
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonArray!, options: [])
                    let postsArray = try JSONDecoder().decode([Post].self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        completion(postsArray)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
}
