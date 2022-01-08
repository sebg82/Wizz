//
//  TabsContentView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct TabsContentView: View {
    
    // To use the mocked data instead of the provider's data,
    // replace UnsplashPhotosImpl() by MockPhotosImpl()
    static var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())
    static let duration: Double = 2.6

    @State private var selectedTab: Tab = .today

    private enum Tab {
        case today
        case search
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            WallMasterDetailView()
                .tabItem {
                    Label("Today", systemImage: "doc.text.image")
                }
                .tag(Tab.today)

            SearchMasterDetailView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)
        }
    }
}

struct TabsContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabsContentView()
    }
}
