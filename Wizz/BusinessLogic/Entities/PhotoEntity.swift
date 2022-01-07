//
//  PhotoEntity.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation
import UIKit

struct PhotoEntity: Identifiable, Hashable {
    static var mock = PhotoEntity(id: "g2E2NQ5SWSU",
                                  user: .mock,
                                  urlRegular: "https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODcwNjZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTY0MDg2NTgwNQ&ixlib=rb-1.2.1&q=80&w=1080",
                                  likes: 123)
    static var mock2 = PhotoEntity(id: "4-tL5J-N-JA",
                                  user: .mock,
                                  urlRegular: "https://images.unsplash.com/photo-1640803971060-d7724041c09c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODcwNjZ8MHwxfGFsbHwyfHx8fHx8Mnx8MTY0MDg2NTgwNQ&ixlib=rb-1.2.1&q=80&w=1080",
                                  likes: 456)
    static var mock3 = PhotoEntity(id: "NIrgYqtKTuk",
                                  user: .mock,
                                  urlRegular: "https://images.unsplash.com/photo-1640844444545-66e19eb6f549?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODcwNjZ8MHwxfGFsbHwzfHx8fHx8Mnx8MTY0MDg2NTgwNQ&ixlib=rb-1.2.1&q=80&w=1080",
                                  likes: 789)
    
    var id: String
    var user: UserEntity
    var urlRegular: String
    var likes: Int
    
    func downloadImage() -> UIImage? {
        
        guard let imageURL = URL(string: urlRegular) else {
            return nil
        }
        
        let cache = URLCache.shared
        let request = URLRequest(url: imageURL, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad)
        if let data = cache.cachedResponse(for: request)?.data {
            return UIImage(data: data)
        } else {
            if let data = try? Data(contentsOf: imageURL) {
                return UIImage(data: data)
            }
        }
        return nil
    }
}
