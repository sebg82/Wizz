//
//  SearchPhotosView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct SearchPhotosView: View {
    
    @State private var searchText = ""
    @StateObject var vm: SearchPhotosViewModel

    var searchResults: [PhotoEntity] {
//        await vm.getSearchPhotos(searchText)
//        return vm.photos
        return []
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.photos) { photo in
                    ZStack {
                        NavigationLink(destination:
                            UserPhotosView(vm: UserPhotosViewModel())
                        ) {
                            EmptyView()
                        }
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                        
                        PhotoRow(photo: photo)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(.inset)
            .navigationBarTitle("Search")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Photos")
        }
        .task {
           await vm.getSearchPhotos("sky")
        }
        .alert("Error", isPresented: $vm.hasError) {
        } message: {
            Text(vm.errorMessage)
        }
    }
}

struct SearchPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPhotosView(vm: SearchPhotosViewModel())
    }
}
