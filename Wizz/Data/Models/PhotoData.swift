//
//  PhotoData.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct PhotoData: Codable {
    let id: String
    let user: UserData
    let urls: UrlsData
    let likes: Int

    struct UrlsData: Codable {
        let regular: String
    }
}

// Conversion BusinessLogic <=> Data
extension PhotoData {
    
    init(_ entity: PhotoEntity) {
        self.init(id: entity.id,
                  user: UserData(entity.user),
                  urls: UrlsData(regular: entity.urlRegular),
                  likes: entity.likes)
    }

    func toEntity() -> PhotoEntity {
        PhotoEntity(id: id,
                    user: user.toEntity(),
                    urlRegular: urls.regular,
                    likes: likes)
    }
}
