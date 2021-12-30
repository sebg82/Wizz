//
//  PhotosInterface.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

protocol PhotosInterface {
    func getPhotos() async throws -> [PhotoEntity]
    func getUserPhotos(_ userId: String) async throws -> [PhotoEntity]
    func getPhotoStatistics(_ photoId: String) async throws -> PhotoStatisticsEntity
    func getSearchPhotos(_ query: String) async throws -> [PhotoEntity]
}
