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
    var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())

    enum Tab {
        case today
        case search
    }

    var body: some View {
        TabView(selection: $selection) {
            TodaysListView(vm: TodaysListViewModel(photosUseCase: photosUseCase))
                .tabItem {
                    Label("Today", systemImage: "doc.text.image")
                }
                .tag(Tab.today)

            SearchPhotosView(vm: SearchPhotosViewModel(photosUseCase: photosUseCase))
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
