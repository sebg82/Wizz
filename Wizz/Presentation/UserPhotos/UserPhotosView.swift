//
//  UserPhotosView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct UserPhotosView: View {
    
    @AppStorage("showDetail") var showDetail = false
    @StateObject var vm: UserPhotosViewModel
    @State var photo: PhotoEntity
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ZStack {
            
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
                                .renderingMode(.template)
                            Text("\(nbViews) views")
                                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                        }
                    }
                    
                    if let nbDownloads = vm.statistics?.downloads {
                        HStack {
                            Image("download")
                                .renderingMode(.template)
                            Text("\(nbDownloads) downloads")
                                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                        }
                    }
                }
                .font(.system(size: 13, weight: .bold, design: .default))
                .foregroundColor(Color(.systemGray))
                .padding(.horizontal, 20)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Image("close")
                        .resizable()
                        .background(.white)
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20)
                        .padding(10)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 2)) {
                                showDetail.toggle()
                            }
                        }
                }
                Spacer()
            }
        }
        .task {
            await vm.getUserPhotos(photo.user.username)
            await vm.getPhotoStatistics(photo.id)
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
                       photo: PhotoEntity(id: "g2E2NQ5SWSU",
                                          user: UserEntity(id: "",
                                                           username: "2DC3GyeqWjI",
                                                           profileImageMedium: ""),
                                          urlRegular: "",
                                          likes: 0))
    }
}

