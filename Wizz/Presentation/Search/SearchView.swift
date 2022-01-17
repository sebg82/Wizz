//
//  SearchView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 04/01/2022.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var vm = SearchViewModel()
    @Binding var showDetails: Bool
    @Binding var selectedPhoto: PhotoEntity?
    var namespace: Namespace.ID
    @Binding var query: String

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
                    ForEach(vm.photos, id: \.id) { photo in
                        PhotoRow(photo: photo, namespace: namespace)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: TabsContentView.duration)) {
                                    selectedPhoto = photo
                                    showDetails = selectedPhoto != nil
                                }
                            }
                    }
                }
            }
            .navigationBarTitle("Search")
            .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Photos")
            .onChange(of: query) { newQuery in
                Task { await vm.getSearchPhotos(query) }
            }
        }
        .task {
            await vm.getSearchPhotos(query)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SearchView(showDetails: .constant(false), selectedPhoto: .constant(nil), namespace: namespace, query: .constant("s"))
    }
}
