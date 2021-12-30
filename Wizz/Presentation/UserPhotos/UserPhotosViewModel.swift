//
//  UserPhotosViewModel.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

@MainActor
class UserPhotosViewModel: ObservableObject {
    
    var photosUseCase = PhotosUseCase(dataSource: MockPhotosImpl())
    @Published var photos: [PhotoEntity] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    
    func getUserPhotos(_ userId: String) async {
        do {
            photos = try await photosUseCase.getUserPhotos(userId)
            errorMessage = ""
        } catch {
            photos = []
            errorMessage = error.localizedDescription
            hasError = true
        }
    }
}