//
//  Photo.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct UPhoto: Codable, Identifiable {
    var id: String
    var user: UUser
    var urls: UUrls
    var likes: Int
}

struct UUser: Codable, Identifiable {
    var id: String
    var username: String
    var profileImage: UProfileImage
    
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case profileImage = "profile_image"
    }
}

struct UProfileImage: Codable {
    var medium: String
}

struct UUrls: Codable {
    var regular: String
}
