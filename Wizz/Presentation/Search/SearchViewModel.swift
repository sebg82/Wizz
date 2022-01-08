//
//  SearchViewModel.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var photos: [PhotoEntity] = []
    
    func getSearchPhotos(_ query: String) async {
        photos = (try? await TabsContentView.photosUseCase.getSearchPhotos(query)) ?? []
    }
}
