//
//  TodaysListView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }

    static var moveAndScale: AnyTransition {
        .asymmetric(
            insertion: .scale(scale: 1, anchor: .topLeading).combined(with: .opacity),
            removal: .scale(scale: 0, anchor: .topLeading).combined(with: .opacity)
        )
    }
}
//extension AnyTransition {
//    static var zoomPhoto: AnyTransition {
//        .modifier(
//            active: ZoomPhotoModifier(size: 0),
//            identity: ZoomPhotoModifier(size: 1)
//        )
//    }
//}


struct TodaysListView: View {

    @StateObject var vm: TodaysListViewModel
    @State private var todayDate: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMM d yyyy"
        return dateFormatter.string(from: Date()).uppercased()
    } ()
    @AppStorage("showDetail") var showDetail = false
    @State private var selectedPhoto: PhotoEntity?

    var body: some View {
        ZStack {

            if showDetail, let selectedPhoto = selectedPhoto {
                UserPhotosView(vm: UserPhotosViewModel(photosUseCase: vm.photosUseCase),
                               photo: selectedPhoto)
                .transition(.moveAndFade)
                .animation(.easeInOut(duration: 2))
            
            } else {
            
                List {
                    Text("\(todayDate)")
                        .font(.system(size: 13, weight: .bold, design: .default))
                        .foregroundColor(Color(.systemGray))
                        .listRowSeparator(.hidden)
                    
                    Text("Today")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                        .listRowSeparator(.hidden)
                    
                    ForEach(vm.photos) { photo in
                        PhotoRow(photo: photo)
                            .onTapGesture {
//                                withAnimation(.easeInOut(duration: 2)) {
                                    selectedPhoto = photo
                                    showDetail.toggle()
//                                }
                            }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.inset)
                .transition(.moveAndScale)
                .animation(.easeInOut(duration: 2))
                .task {
                   await vm.getPhotos()
                }
                .alert("Error", isPresented: $vm.hasError) {
                } message: {
                    Text(vm.errorMessage)
                }
            }
        }
    }
}

struct TodaysListView_Previews: PreviewProvider {
    static var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())

    static var previews: some View {
        TodaysListView(vm: TodaysListViewModel(photosUseCase: photosUseCase))
    }
}
