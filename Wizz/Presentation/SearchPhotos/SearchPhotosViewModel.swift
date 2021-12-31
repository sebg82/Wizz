//
//  SearchPhotosViewModel.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

@MainActor
class SearchPhotosViewModel: ObservableObject {
    
    var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())
    @Published var photos: [PhotoEntity] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    
    func getSearchPhotos(_ query: String) async {
        do {
            photos = try await photosUseCase.getSearchPhotos(query)
            errorMessage = ""
            hasError = false
        } catch {
            photos = []
            errorMessage = error.localizedDescription
            hasError = true
        }
    }
}
