//
//  DetailsView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 03/01/2022.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject var vm = DetailsViewModel()
    @Binding var showDetails: Bool
    @Binding var selectedPhoto: PhotoEntity?
    var namespace: Namespace.ID
    @State private var showPlaceholderForAnimation: Bool = true
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ZStack {
            scrollingPhotos
            closeButton
        }
    }
    
    var closeButton: some View {
        Button {
            withAnimation(.easeInOut(duration: TabsContentView.duration)) {
                showDetails = false
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
//        .ignoresSafeArea()
    }
    
    var scrollingPhotos: some View {
        ScrollView {

            if showPlaceholderForAnimation, let selectedPhoto = selectedPhoto {
                LazyVGrid(columns: columns, spacing: 10) {
                    Image(uiImage: UIImage.fromCache(orUrl: selectedPhoto.urlRegular))
                        .resizable()
                        .matchedGeometryEffect(id: "\(selectedPhoto.id)", in: namespace)
                        .aspectRatio(1, contentMode: .fill)
    //                        .animation(.easeInOut(duration: Self.duration))
                        .onAppear {
                            // When animation finished
                            DispatchQueue.main.asyncAfter(deadline: .now() + TabsContentView.duration) {
                                showPlaceholderForAnimation = false
                            }
                        }
                }
                .padding(10)

            } else {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(vm.photos, id: \.id) { photo in
                        Image(uiImage: UIImage.fromCache(orUrl: photo.urlRegular))
                            .resizable()
                            .matchedGeometryEffect(id: "\(photo.id)", in: namespace)
                            .aspectRatio(1, contentMode: .fill)
    //                            .animation(.easeInOut(duration: Self.duration))
                    }
                }
                .padding(10)

                photoStatistics
            }
        }
//        .ignoresSafeArea()
        .task {
            if let selectedPhoto = selectedPhoto {
                await vm.getUserPhotos(of: selectedPhoto)
                await vm.getPhotoStatistics(selectedPhoto.id)
            }
        }
    }
    
    var photoStatistics: some View {
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
}

struct DetailsView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        DetailsView(showDetails: .constant(true), selectedPhoto: .constant(.mock), namespace: namespace)
.previewInterfaceOrientation(.portrait)
    }
}
