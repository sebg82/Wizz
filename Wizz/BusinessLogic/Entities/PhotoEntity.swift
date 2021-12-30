//
//  PhotoEntity.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct PhotoEntity: Equatable, Identifiable {
    var id: String
    var user: UserEntity
    var urlRegular: String
    var likes: Int
}
