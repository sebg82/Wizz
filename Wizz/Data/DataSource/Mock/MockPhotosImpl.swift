//
//  MockPhotosImpl.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct MockPhotosImpl : PhotosInterface {
    
    func getPhotos() async throws -> [PhotoEntity] {
        let result: [PhotoData] = try getData(from: "photosData.json")
        return result.compactMap { $0.toEntity() }
    }
    
    func getUserPhotos(_ userId: String) async throws -> [PhotoStatisticsEntity] {
        let result: [PhotoStatisticsData] = try getData(from: "userPhotosData.json")
        return result.compactMap { $0.toEntity() }
    }
    
    func getPhotoStatistics(_ photoId: String) async throws -> PhotoStatisticsEntity {
        let result: PhotoStatisticsData = try getData(from: "photoStatisticsData.json")
        return result.toEntity()
    }
    
    func getSearchPhotos(_ query: String) async throws -> [PhotoEntity] {
        let result: SearchPhotosData = try getData(from: "searchPhotosData.json")
        return result.results.compactMap { $0.toEntity() }
    }
    
    private func getData<Element: Decodable>(from filename: String) throws -> Element {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        let data = try! Data(contentsOf: url!)
        let result = try! JSONDecoder().decode(Element.self, from: data)
        return result
    }
}
