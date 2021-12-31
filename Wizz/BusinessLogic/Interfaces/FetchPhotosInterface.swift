//
//  FetchPhotosInterface.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

protocol FetchPhotosInterface {
    func fetchPhotos() async throws -> [PhotoEntity]
    func fetchUserPhotos(_ userId: String) async throws -> [PhotoEntity]
    func fetchPhotoStatistics(_ photoId: String) async throws -> PhotoStatisticsEntity
    func fetchSearchPhotos(_ query: String) async throws -> [PhotoEntity]
}
