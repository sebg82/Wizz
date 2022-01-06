//
//  UserPhotosViewModel.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

@MainActor
class UserPhotosViewModel: ObservableObject {
    
    @Published var statistics: PhotoStatisticsEntity?
    @Published var photos: [PhotoEntity] = []
    @Published var errorMessage = ""
    @Published var hasError = false


    func getUserPhotos(_ userId: String) async {
        do {
            photos = try await ContentView.photosUseCase.getUserPhotos(userId)
            errorMessage = ""
            hasError = false
        } catch {
            photos = []
            errorMessage = error.localizedDescription
            hasError = true
        }
    }
    
    func getPhotoStatistics(_ photoId: String) async {
        do {
            statistics = try await ContentView.photosUseCase.getPhotoStatistics(photoId)
            errorMessage = ""
            hasError = false
        } catch {
            photos = []
            errorMessage = error.localizedDescription
            hasError = true
        }
    }
}
