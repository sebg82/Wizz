//
//  SavePhotosInterface.swift
//  Wizz
//
//  Created by Sebastien Gohier on 31/12/2021.
//

import Foundation

protocol SavePhotosInterface {
    func savePhotos(_ photos: [PhotoEntity]) async throws
    func saveUserPhotos(_ photos: [PhotoEntity], for userId: String) async throws
    func savePhotoStatistics(_ statistics: PhotoStatisticsEntity, for photoId: String) async throws
    func saveSearchPhotos(_ photos: [PhotoEntity], for query: String) async throws
}
