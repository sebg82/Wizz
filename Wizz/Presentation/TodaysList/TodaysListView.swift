//
//  TodaysListView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 03/01/2022.
//

import SwiftUI

struct TodaysListView: View {
    
    @StateObject var vm: TodaysListViewModel
    @State private var todayDate: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMM d yyyy"
        return dateFormatter.string(from: Date()).uppercased()
    } ()
    @Binding var selectedPhoto: PhotoEntity?

    var namespace: Namespace.ID
    @Binding var showUserPhotos: Bool

    var body: some View {
        
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
                PhotoRow(namespace: namespace, photo: photo)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            selectedPhoto = photo
                            showUserPhotos.toggle()
                        }
                    }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
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
    @Namespace static var namespace

    static var vm = TodaysListViewModel(photosUseCase: PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl()))
    
    static var previews: some View {
        TodaysListView(vm: vm,
                       selectedPhoto: .constant(.mock),
                       namespace: namespace,
                       showUserPhotos: .constant(true))
    }
}
