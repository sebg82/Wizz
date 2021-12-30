//
//  SearchPhotosViewModel.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

@MainActor
class SearchPhotosViewModel: ObservableObject {
    
    var photosUseCase = PhotosUseCase(dataSource: UnsplashPhotosImpl())
    @Published var photos: [PhotoEntity] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    
    func getSearchPhotos(_ query: String) async {
        do {
            photos = try await photosUseCase.getSearchPhotos(query)
            errorMessage = ""
        } catch {
            photos = []
            errorMessage = error.localizedDescription
            hasError = true
        }
    }
}
