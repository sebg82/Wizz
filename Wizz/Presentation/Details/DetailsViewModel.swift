//
//  DetailsViewModel.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

@MainActor
class DetailsViewModel: ObservableObject {
    
    @Published var statistics: PhotoStatisticsEntity?
    @Published var photos: [PhotoEntity] = []
    @Published var errorMessage = ""
    @Published var hasError = false


    func getUserPhotos(of selectedPhoto: PhotoEntity) async {
        do {
            var tmpPhotos = try await TabsContentView.photosUseCase.getUserPhotos(selectedPhoto.user.username)
            if tmpPhotos.contains(where: { $0.id == selectedPhoto.id }) {
                tmpPhotos.removeAll(where: { $0.id == selectedPhoto.id })
            } else {
                tmpPhotos.removeLast()
            }
            tmpPhotos.insert(selectedPhoto, at: 0)
            photos = tmpPhotos
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
            statistics = try await TabsContentView.photosUseCase.getPhotoStatistics(photoId)
            errorMessage = ""
            hasError = false
        } catch {
            photos = []
            errorMessage = error.localizedDescription
            hasError = true
        }
    }
}
