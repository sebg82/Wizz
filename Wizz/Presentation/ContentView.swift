//
//  ContentView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .today

    // To use the mocked data instead of the provider's data,
    // replace UnsplashPhotosImpl() by MockPhotosImpl()
    static var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())

    enum Tab {
        case today
        case search
    }

    var body: some View {
        TabView(selection: $selection) {
            TodaysListMasterDetailView()
                .tabItem {
                    Label("Today", systemImage: "doc.text.image")
                }
                .tag(Tab.today)

            SearchPhotosMasterDetailView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
