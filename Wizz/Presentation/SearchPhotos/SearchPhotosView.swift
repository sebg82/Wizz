//
//  SearchPhotosView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct SearchPhotosView: View {

    @StateObject var vm: SearchPhotosViewModel
    @State private var query = ""
    @AppStorage("showDetail") var showDetail = false
    @State private var selectedPhoto: PhotoEntity?
    
    var body: some View {
        ZStack {

            if showDetail, let selectedPhoto = selectedPhoto {
                UserPhotosView(vm: UserPhotosViewModel(photosUseCase: vm.photosUseCase),
                               photo: selectedPhoto)
//                .transition(.moveAndFade)
//                .animation(.default)
            
            } else {
            
                NavigationView {
                    List {
                        ForEach(vm.photos) { photo in
                            PhotoRow(photo: photo)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 2)) {
                                        selectedPhoto = photo
                                        showDetail.toggle()
                                    }
                                }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.inset)
                    .navigationBarTitle("Search")
                    .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Photos")
                    .onChange(of: query) { newQuery in
                        Task { await vm.getSearchPhotos(query) }
                    }
                }
            }
        }
    }
}

struct SearchPhotosView_Previews: PreviewProvider {
    static var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())

    static var previews: some View {
        SearchPhotosView(vm: SearchPhotosViewModel(photosUseCase: photosUseCase))
    }
}
