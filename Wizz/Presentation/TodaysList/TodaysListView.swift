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
}

struct TodaysListView: View {
    @StateObject var vm: TodaysListViewModel
    @State private var todayDate: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMM d yyyy"
        return dateFormatter.string(from: Date()).uppercased()
    } ()

    var body: some View {
        NavigationView {
            List {
                Text("\(todayDate)")
                    .listRowSeparator(.hidden)
                ForEach(vm.photos) { photo in
                    ZStack {
                        NavigationLink(destination:
                                        UserPhotosView(vm: UserPhotosViewModel(photosUseCase: vm.photosUseCase),
                                           userId: photo.user.username,
                                           photoId: photo.id)
//                                            .transition(.move(edge: .top))
//                                            .animation(.default)
                        ) {
                            EmptyView()
                        }
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                        
                        PhotoRow(photo: photo)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            .font(.system(size: 13, weight: .bold, design: .default))
            .foregroundColor(Color(.systemGray))
            .navigationBarTitle("Today")
        }
        .task {
           await vm.getPhotos()
        }
        .alert("Error", isPresented: $vm.hasError) {
        } message: {
            Text(vm.errorMessage)
        }
    }
}

struct TodaysListView_Previews: PreviewProvider {
    static var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())

    static var previews: some View {
        TodaysListView(vm: TodaysListViewModel(photosUseCase: photosUseCase))
    }
}
