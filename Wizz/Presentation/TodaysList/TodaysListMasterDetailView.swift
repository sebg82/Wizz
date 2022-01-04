//
//  TodaysListMasterDetailView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct TodaysListMasterDetailView: View {

    @StateObject var vm: TodaysListViewModel
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
                    .onTapGesture {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showUserPhotos.toggle()
                        }
                    }
            } else {
                TodaysListView(vm: vm,
                               selectedPhoto: $selectedPhoto,
                               namespace: namespace,
                               showUserPhotos: $showUserPhotos)
            }
        }
    }
}

struct TodaysListMasterDetailView_Previews: PreviewProvider {
    static var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())

    static var previews: some View {
        TodaysListMasterDetailView(vm: TodaysListViewModel(photosUseCase: photosUseCase))
    }
}
