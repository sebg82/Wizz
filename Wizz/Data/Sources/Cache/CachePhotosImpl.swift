//
//  CachePhotosImpl.swift
//  Wizz
//
//  Created by Sebastien Gohier on 31/12/2021.
//

import Foundation

struct CachePhotosImpl {}

extension CachePhotosImpl: FetchPhotosInterface {
    
    func fetchPhotos() async throws -> [PhotoEntity] {
        let result: [PhotoData] = try getObject(from: "photos.json")
        return result.compactMap { $0.toEntity() }
    }
    
    func fetchUserPhotos(_ userId: String) async throws -> [PhotoEntity] {
        let result: [PhotoData] = try getObject(from: "users(\(userId))-photos.json")
        return result.compactMap { $0.toEntity() }
    }
    
    func fetchPhotoStatistics(_ photoId: String) async throws -> PhotoStatisticsEntity {
        let result: PhotoStatisticsData = try getObject(from: "photos(\(photoId))-statistics.json")
        return result.toEntity()
    }
    
    func fetchSearchPhotos(_ query: String) async throws -> [PhotoEntity] {
        let result: SearchPhotosData = try getObject(from: "search(\(query))-photos.json")
        return result.results.compactMap { $0.toEntity() }
    }
    
    private func getObject<Element: Decodable>(from filename: String) throws -> Element {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
        let data = try Data(contentsOf: path)
        let result = try JSONDecoder().decode(Element.self, from: data)
        return result
    }
}

extension CachePhotosImpl: SavePhotosInterface {
    
    func savePhotos(_ photos: [PhotoEntity]) async throws {
        let objData = photos.compactMap { PhotoData($0) }
        try setObject(objData, to: "photos.json")
    }

    func saveUserPhotos(_ photos: [PhotoEntity], for userId: String) async throws {
        let objData = photos.compactMap { PhotoData($0) }
        try setObject(objData, to: "users(\(userId))-photos.json")
    }
    
    func savePhotoStatistics(_ statistics: PhotoStatisticsEntity, for photoId: String) async throws {
        let objData = PhotoStatisticsData(statistics)
        try setObject(objData, to: "photos(\(photoId))-statistics.json")
    }

    func saveSearchPhotos(_ photos: [PhotoEntity], for query: String) async throws {
        let objData = photos.compactMap { PhotoData($0) }
        try setObject(objData, to: "search(\(query))-photos.json")
    }
    
    private func setObject<Element: Encodable>(_ object: Element, to filename: String) throws {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
        let jsonData = try JSONEncoder().encode(object)
        try jsonData.write(to: url)
    }
}
