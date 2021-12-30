//
//  PhotoStatisticsData.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct PhotoStatisticsData: Codable {
    let id: String
    let downloads: TotalData
    let likes: TotalData
    let views: TotalData 

    struct TotalData: Codable {
        let total: Int
    }
}

// Conversion BusinessLogic <=> Data
extension PhotoStatisticsData {
    
    init(_ entity: PhotoStatisticsEntity) {
        self.init(id: entity.id,
                  downloads: TotalData(total: entity.downloads),
                  likes: TotalData(total: entity.likes),
                  views: TotalData(total: entity.views))
    }

    func toEntity() -> PhotoStatisticsEntity {
        PhotoStatisticsEntity(id: id,
                              downloads: downloads.total,
                              likes: likes.total,
                              views: views.total)
    }
}
