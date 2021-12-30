//
//  UnsplashPhotosImpl.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

struct UnsplashPhotosImpl : PhotosInterface {
    
    func getPhotos() async throws -> [PhotoEntity] {
        let result: [PhotoData] = try await getData("photos", query: [:])
        return result.compactMap { $0.toEntity() }
    }
    
    func getUserPhotos(_ userId: String) async throws -> [PhotoEntity] {
        let result: [PhotoData] = try await getData("users/\(userId)/photos", query: [:])
        return result.compactMap { $0.toEntity() }
    }
    
    func getPhotoStatistics(_ photoId: String) async throws -> PhotoStatisticsEntity {
        let result: PhotoStatisticsData = try await getData("photos/\(photoId)/statistics", query: [:])
        return result.toEntity()
    }
    
    func getSearchPhotos(_ query: String) async throws -> [PhotoEntity] {
        let result: SearchPhotosData = try await getData("search/photos", query: ["query": query])
        return result.results.compactMap { $0.toEntity() }
    }

    private func getData<Element: Decodable>(_ stringUrl: String, query: [String : Any]) async throws -> Element {
        let request = try urlRequest(relativePath: stringUrl, queryParameters: query)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let object = try JSONSerialization.jsonObject(with: data, options: [])
        let data2 = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])
        print( NSString(data: data2, encoding: String.Encoding.utf8.rawValue)! )
        
        let result = try JSONDecoder().decode(Element.self, from: data)
        return result
    }
    
    private func urlRequest(relativePath: String, queryParameters: [String: Any] = [:]) throws -> URLRequest {
        
        var components = URLComponents(string: "https://api.unsplash.com/\(relativePath)")!
        components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest(url: components.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("v1", forHTTPHeaderField: "Accept-Version")
        request.addValue("Client-ID Ld04xNk1TffjnlgPweCsX1H0ZqVbDIABzdqPCnXUrs4", forHTTPHeaderField: "Authorization")
        return request
    }
}
