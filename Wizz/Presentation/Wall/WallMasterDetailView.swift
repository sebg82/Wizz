//
//  WallMasterDetailView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct WallMasterDetailView: View {
    @StateObject var wallvm = WallViewModel()
    @StateObject var detailsvm = DetailsViewModel()

    @State var selectedPhoto: PhotoEntity?
    @Namespace private var namespace
    @State var showDetailDest: Bool = true
    
    static let duration: Double = 3.0
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        ZStack {
            if let selected = selectedPhoto {
//                DetailsView(selectedPhoto: $selectedPhoto, namespace: namespace)
                ZStack {
                    if showDetailDest {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 0) {
                                Image(uiImage: selected.downloadImage() ?? UIImage())
                                    .resizable()
                                    .matchedGeometryEffect(id: "\(selected.id)", in: namespace)
                                    .frame(width: 200, height: 100, alignment: .trailing)
//                                    .animation(.easeInOut(duration: Self.duration))
                                    .onAppear {
                                        // When animation finished
                                        DispatchQueue.main.asyncAfter(deadline: .now() + Self.duration) {
                                            showDetailDest = false
                                        }
                                    }
    //                            Text(selected.user.username+"-"+selected.id)
                            }
                        }

                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 0) {
                                ForEach(detailsvm.photos, id: \.self) { photo in
                                    Image(uiImage: photo.downloadImage() ?? UIImage())
                                        .resizable()
                                        .matchedGeometryEffect(id: "\(photo.id)", in: namespace)
                                        .frame(width: 200, height: 100, alignment: .trailing)
//                                        .animation(.easeInOut(duration: Self.duration))
                                        .onTapGesture {
                                            withAnimation(.easeInOut(duration: Self.duration)) {
                                                selectedPhoto = nil
                                                showDetailDest = true
                                            }
                                        }
                                    Text(photo.user.username+"-"+photo.id)
                                }
                            }
                        }
                    }
                }
                .task {
                    if let selectedPhoto = selectedPhoto {
                        await detailsvm.getUserPhotos(of: selectedPhoto)
                        await detailsvm.getPhotoStatistics(selectedPhoto.id)
                    }
                }
                .alert("Error", isPresented: $detailsvm.hasError) {
                } message: {
                    Text(detailsvm.errorMessage)
                }
            } else { 
//                WallView(selectedPhoto: $selectedPhoto, namespace: namespace)
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(wallvm.photos, id: \.self) { photo in
                                Image(uiImage: photo.downloadImage() ?? UIImage())
                                    .resizable()
                                    .matchedGeometryEffect(id: "\(photo.id)", in: namespace)
                                    .frame(width: 100, height: 100, alignment: .leading)
//                                    .animation(.easeInOut(duration: Self.duration))
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: Self.duration)) {
                                            selectedPhoto = photo
                                        }
                                    }
                                Text(photo.user.username+"-"+photo.id)
                            }
                        }
                    }
//                    .animation(.easeInOut(duration: Self.duration))
                    .task {
                       await wallvm.getPhotos()
                    }
                    .alert("Error", isPresented: $wallvm.hasError) {
                    } message: {
                        Text(wallvm.errorMessage)
                    }
                }
            }
        }
    }
}

struct WallMasterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WallMasterDetailView()
    }
}
