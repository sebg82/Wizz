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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.photos) { photo in
                    ZStack {
                        NavigationLink(destination:
                            UserPhotosView(vm: UserPhotosViewModel(photosUseCase: vm.photosUseCase),
                                           userId: photo.user.username,
                                           photoId: photo.id)
                        ) {
                            EmptyView()
                        }
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                        
                        PhotoRow(photo: photo)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.inset)
            .navigationBarTitle("Search")
            .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Photos")
            .onChange(of: query) { newQuery in
                Task { await vm.getSearchPhotos(query) }
            }
        }
        .task {
            await vm.getSearchPhotos(query)
        }
        .alert("Error", isPresented: $vm.hasError) {
        } message: {
            Text(vm.errorMessage)
        }
    }
}

struct SearchPhotosView_Previews: PreviewProvider {
    static var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())

    static var previews: some View {
        SearchPhotosView(vm: SearchPhotosViewModel(photosUseCase: photosUseCase))
    }
}
