//
//  PhotoStatisticsEntity.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct PhotoStatisticsEntity: Identifiable, Hashable {
    var id: String
    var downloads: Int
    var likes: Int
    var views: Int
}
