//
//  UserData.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct UserData: Codable {
    let id: String
    let username: String
    let profileImage: ProfileImageData
    
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case profileImage = "profile_image"
    }

    struct ProfileImageData: Codable {
        let medium: String
    }
}

// Conversion BusinessLogic <=> Data
extension UserData {
    
    init(_ entity: UserEntity) {
        self.init(id: entity.id,
                  username: entity.username,
                  profileImage: ProfileImageData(medium: entity.profileImageMedium))
    }

    func toEntity() -> UserEntity {
        UserEntity(id: id,
                   username: username,
                   profileImageMedium: profileImage.medium)
    }
}
