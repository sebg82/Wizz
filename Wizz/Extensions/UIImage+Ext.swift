//
//  UIImage+Ext.swift
//  Wizz
//
//  Created by Sebastien Gohier on 08/01/2022.
//

import UIKit

extension UIImage {
    static func fromCache(orUrl: String) -> UIImage {
        
        guard let imageURL = URL(string: orUrl) else {
            return UIImage()
        }
        
        let cache = URLCache.shared
        let request = URLRequest(url: imageURL, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad)
        if let data = cache.cachedResponse(for: request)?.data {
            return UIImage(data: data) ?? UIImage()
        } else {
            if let data = try? Data(contentsOf: imageURL) {
                return UIImage(data: data) ?? UIImage()
            }
        }
        return UIImage()
    }
}
