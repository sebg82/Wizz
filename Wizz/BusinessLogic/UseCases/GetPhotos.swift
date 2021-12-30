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
    }

    func getUserPhotos(_ userId: String) async throws -> [PhotoStatisticsEntity] {
        try await dataSource.getUserPhotos(userId)
    }

    func getPhotoStatistics(_ photoId: String) async throws -> PhotoStatisticsEntity {
        try await dataSource.getPhotoStatistics(photoId)
    }

    func getSearchPhotos(_ query: String) async throws -> [SearchPhotosEntity] {
        try await dataSource.getSearchPhotos(query)
    }
}
