//
//  TodaysListViewModel.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

@MainActor
class TodaysListViewModel: ObservableObject {

    @Published var photos: [PhotoEntity] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    
    func getPhotos() async {
        do {
            photos = try await ContentView.photosUseCase.getPhotos()
            errorMessage = ""
            hasError = false
        } catch {
            photos = []
            errorMessage = error.localizedDescription
            hasError = true
        }
    }
}
