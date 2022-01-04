//
//  SearchPhotosMasterDetailView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct SearchPhotosMasterDetailView: View {

    @StateObject var vm: SearchPhotosViewModel
    @State private var query = ""
    @State private var selectedPhoto: PhotoEntity?
    
    @Namespace var namespace
    @State var showUserPhotos = false

    var body: some View {
        ZStack {
            if showUserPhotos {
                UserPhotosView(vm: UserPhotosViewModel(photosUseCase: vm.photosUseCase),
                               photo: selectedPhoto!,
                               namespace: namespace,
                               showUserPhotos: $showUserPhotos)
            } else {
                SearchPhotosView(vm: vm,
                                 namespace: namespace,
                                 showUserPhotos: $showUserPhotos)
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showUserPhotos.toggle()
            }
        }
//        ZStack {
//
//            if showUserPhotos, let selectedPhoto = selectedPhoto {
//                UserPhotosView_old(vm: UserPhotosViewModel(photosUseCase: vm.photosUseCase),
//                               photo: selectedPhoto)
//
//            } else {
//
//                NavigationView {
//                    List {
//                        ForEach(vm.photos) { photo in
//                            PhotoRow(photo: photo)
//                                .onTapGesture {
//                                    withAnimation(.easeInOut(duration: 2)) {
//                                        selectedPhoto = photo
//                                        showUserPhotos.toggle()
//                                    }
//                                }
//                        }
//                        .listRowSeparator(.hidden)
//                    }
//                    .listStyle(.inset)
//                    .navigationBarTitle("Search")
//                    .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Photos")
//                    .onChange(of: query) { newQuery in
//                        Task { await vm.getSearchPhotos(query) }
//                    }
//                }
//            }
//        }
    }
}

struct SearchPhotosMasterDetailView_Previews: PreviewProvider {
    static var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())

    static var previews: some View {
        SearchPhotosMasterDetailView(vm: SearchPhotosViewModel(photosUseCase: photosUseCase))
    }
}
