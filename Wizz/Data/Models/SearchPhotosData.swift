//
//  SearchPhotosData.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct SearchPhotosData: Codable {
    let results: [PhotoData]
}

// Conversion BusinessLogic <=> Data
extension SearchPhotosData {
    
    init(_ entity: [PhotoEntity]) {
        self.init(results: entity.compactMap { PhotoData($0) } )
    }

    func toEntity() -> [PhotoEntity] {
        results.compactMap { $0.toEntity() }
    }
}
