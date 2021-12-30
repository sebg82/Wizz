//
//  PhotosUseCase.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct PhotosUseCase {

    let dataSource: PhotosInterface
    
    func getPhotos() async throws -> [PhotoEntity] {
        try await dataSource.getPhotos()
        // implements business logic here
    }

    func getUserPhotos(_ userId: String) async throws -> [PhotoStatisticsEntity] {
        try await dataSource.getUserPhotos(userId)
        // implements business logic here
    }

    func getPhotoStatistics(_ photoId: String) async throws -> PhotoStatisticsEntity {
        try await dataSource.getPhotoStatistics(photoId)
        // implements business logic here
    }

    func getSearchPhotos(_ query: String) async throws -> [PhotoEntity] {
        try await dataSource.getSearchPhotos(query)
        // implements business logic here
    }
}
