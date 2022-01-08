//
//  PhotosUseCase.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

// Implements business logic here
struct PhotosUseCase {

    let source: FetchPhotosInterface
    let cache: FetchPhotosInterface & SavePhotosInterface
    
    func getPhotos() async throws -> [PhotoEntity] {
        // Get the photos from the provider
        if let photos = try? await source.fetchPhotos() {
            
            // Save the photos in the device
            try? await cache.savePhotos(photos)
            return photos
        }

        // Else return the photos from the cache
        return try await cache.fetchPhotos()
    }

    func getUserPhotos(_ userId: String) async throws -> [PhotoEntity] {
        
        // Get the photos from the provider
        if let photos = try? await source.fetchUserPhotos(userId) {
            
            // Save the photos in the device
            try? await cache.saveUserPhotos(photos, for: userId)
            return photos
        }

        // Else return the photos from the cache
        return try await cache.fetchUserPhotos(userId)
    }

    func getPhotoStatistics(_ photoId: String) async throws -> PhotoStatisticsEntity {

        // Get the photos from the provider
        if let statistics = try? await source.fetchPhotoStatistics(photoId) {
            
            // Save the statistics in the device
            try? await cache.savePhotoStatistics(statistics, for: photoId)
            return statistics
        }

        // Else return the statistics from the cache
        return try await cache.fetchPhotoStatistics(photoId)
    }

    func getSearchPhotos(_ query: String) async throws -> [PhotoEntity] {
        
        // Get the photos from the provider
        if let photos = try? await source.fetchSearchPhotos(query) {

            // Save the photos in the device
            try? await cache.saveSearchPhotos(photos, for: query)
            return photos
        }

        // Else return the photos from the cache
        return try await cache.fetchSearchPhotos(query)
    }
}
