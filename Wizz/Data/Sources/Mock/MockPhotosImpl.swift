//
//  MockPhotosImpl.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct MockPhotosImpl : FetchPhotosInterface {
    
    func fetchPhotos() async throws -> [PhotoEntity] {
        let result: [PhotoData] = try getObject(from: "photosData.json")
        return result.compactMap { $0.toEntity() }
    }
    
    func fetchUserPhotos(_ userId: String) async throws -> [PhotoEntity] {
        let result: [PhotoData] = try getObject(from: "userPhotosData.json")
        return result.compactMap { $0.toEntity() }
    }
    
    func fetchPhotoStatistics(_ photoId: String) async throws -> PhotoStatisticsEntity {
        let result: PhotoStatisticsData = try getObject(from: "photoStatisticsData.json")
        return result.toEntity()
    }
    
    func fetchSearchPhotos(_ query: String) async throws -> [PhotoEntity] {
        let result: SearchPhotosData = try getObject(from: "searchPhotosData.json")
        return result.results.compactMap { $0.toEntity() }
    }
    
    private func getObject<Element: Decodable>(from filename: String) throws -> Element {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        let data = try Data(contentsOf: url!)
        let result = try JSONDecoder().decode(Element.self, from: data)
        return result
    }
}
