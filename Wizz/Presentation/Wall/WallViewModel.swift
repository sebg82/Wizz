//
//  WallViewModel.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

@MainActor
class WallViewModel: ObservableObject {

    @Published var photos: [PhotoEntity] = []
    
    func getPhotos() async {
        photos = (try? await TabsContentView.photosUseCase.getPhotos()) ?? []
    }
}
