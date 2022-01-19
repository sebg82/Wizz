//
//  SearchMasterDetailView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct SearchMasterDetailView: View {
    
    @State var showDetails: Bool = false
    @State var selectedPhoto: PhotoEntity?
    @Namespace private var namespace
    @State var query = ""

    var body: some View {
        if showDetails {
            DetailsView(showDetails: $showDetails, selectedPhoto: $selectedPhoto, namespace: namespace)
        } else {
            SearchView(showDetails: $showDetails, selectedPhoto: $selectedPhoto, namespace: namespace, query: $query)
        }
    }
}

struct SearchMasterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMasterDetailView()
    }
}
