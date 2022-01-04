//
//  PhotoEntity.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct PhotoEntity: Identifiable, Hashable {
    static var mock = PhotoEntity(id: "g2E2NQ5SWSU",
                                  user: .mock,
                                  urlRegular: "https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODcwNjZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTY0MDg2NTgwNQ&ixlib=rb-1.2.1&q=80&w=1080",
                                  likes: 2356)
    
    var id: String
    var user: UserEntity
    var urlRegular: String
    var likes: Int
}
