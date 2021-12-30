//
//  UserPhotosViewModel.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

@MainActor
class UserPhotosViewModel: ObservableObject {
    
    var photosUseCase = PhotosUseCase(dataSource: UnsplashPhotosImpl())
    @Published var photosStatistics: [PhotoStatisticsEntity] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    
    func getUserPhotos(_ userId: String) async {
        do {
            photosStatistics = try await photosUseCase.getUserPhotos(userId)
            errorMessage = ""
        } catch {
            photosStatistics = []
            errorMessage = error.localizedDescription
            hasError = true
        }
    }
}
