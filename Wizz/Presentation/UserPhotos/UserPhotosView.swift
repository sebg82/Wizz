//
//  UserPhotosView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct UserPhotosView: View {
    
    @StateObject var vm: UserPhotosViewModel
    var userId: String
    var photoId: String
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ScrollView {

            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(vm.photos){ photo in
                    AsyncImage(url: URL(string: photo.urlRegular)) { image in
                        image.resizable()
                            .frame(alignment: .center)
                    } placeholder: {
                        Color.clear
                    }
                    .padding(5)
                    .aspectRatio(1, contentMode: .fit)
                }
            }

            VStack {
                Text("Picture Statistics")
                    .font(.system(size: 17))
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                
                if let nbViews = vm.statistics?.views {
                    HStack {
                        Image("views")
                        Text("\(nbViews) views")
                            .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    }
                }
                
                if let nbDownloads = vm.statistics?.downloads {
                    HStack {
                        Image("download")
                        Text("\(nbDownloads) downloads")
                            .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    }
                }
            }
            .font(.system(size: 13, weight: .bold, design: .default))
            .foregroundColor(Color(.systemGray2))
            .padding(.horizontal, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarHidden(true)
        .task {
            await vm.getUserPhotos(userId)
            await vm.getPhotoStatistics(photoId)
        }
        .alert("Error", isPresented: $vm.hasError) {
        } message: {
            Text(vm.errorMessage)
        }
    }
}

struct UserPhotosView_Previews: PreviewProvider {
    static var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())

    static var previews: some View {
        UserPhotosView(vm: UserPhotosViewModel(photosUseCase: photosUseCase),
                       userId: "2DC3GyeqWjI",
                       photoId: "g2E2NQ5SWSU")
    }
}

