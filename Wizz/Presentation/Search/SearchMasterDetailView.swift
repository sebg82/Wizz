//
//  SearchMasterDetailView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct SearchMasterDetailView: View {

    @StateObject var vm = SearchViewModel()
    @State private var query = ""
    @State var selectedPhoto: PhotoEntity?
    @Namespace private var namespace

    var body: some View {
        ZStack {
            if selectedPhoto != nil {
                DetailsView(selectedPhoto: $selectedPhoto, namespace: namespace)
            } else {
                SearchView(namespace: namespace)
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                selectedPhoto = nil
            }
        }
//        ZStack {
//
//            if selectedPhoto != nil {
//                DetailsView_old(photo: selectedPhoto)
//
//            } else {
//
//                NavigationView {
//                    List {
//                        ForEach(vm.photos) { photo in
//                            PhotoRow(photo: photo)
//                                .onTapGesture {
//                                    withAnimation(.easeInOut(duration: 2)) {
//                                        selectedPhoto = photo
//                                    }
//                                }
//                        }
//                        .listRowSeparator(.hidden)
//                    }
//                    .listStyle(.inset)
//                    .navigationBarTitle("Search")
//                    .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Photos")
//                    .onChange(of: query) { newQuery in
//                        Task { await vm.getSearchPhotos(query) }
//                    }
//                }
//            }
//        }
    }
}

struct SearchMasterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMasterDetailView()
    }
}
