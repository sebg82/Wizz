//
//  UserEntity.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct UserEntity: Equatable, Identifiable {
    var id: String
    var username: String
    var profileImageMedium: String
}
