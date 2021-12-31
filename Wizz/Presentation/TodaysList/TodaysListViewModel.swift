//
//  TodaysListViewModel.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

@MainActor
class TodaysListViewModel: ObservableObject {

    var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())
    @Published var photos: [PhotoEntity] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    
    func getPhotos() async {
        do {
            photos = try await photosUseCase.getPhotos()
//            let userPhotos = try await photosUseCase.fetchUserPhotos("xps")
//            print(userPhotos)
//            let photosStatistics = try await photosUseCase.fetchPhotoStatistics("g2E2NQ5SWSU")
//            print(photosStatistics)
            errorMessage = ""
            hasError = false
        } catch {
            photos = []
            errorMessage = error.localizedDescription
            hasError = true
        }
    }
}
