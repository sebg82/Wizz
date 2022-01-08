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
        } catch {
            photos = []
        }
    }
    
    func getPhotoStatistics(_ photoId: String) async {
        statistics = try? await TabsContentView.photosUseCase.getPhotoStatistics(photoId)
    }
}
