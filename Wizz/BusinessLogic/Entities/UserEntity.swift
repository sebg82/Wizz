//
//  UserEntity.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct UserEntity: Identifiable, Hashable {
    static var mock = UserEntity(id: "2DC3GyeqWjI",
                                 username: "xps",
                                 profileImageMedium: "https://images.unsplash.com/profile-1600096866391-b09a1a53451aimage?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64")
    
    var id: String
    var username: String
    var profileImageMedium: String
}
