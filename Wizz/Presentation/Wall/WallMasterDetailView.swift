//
//  WallMasterDetailView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct WallMasterDetailView: View {
    
    @State var showDetails: Bool = false
    @State var selectedPhoto: PhotoEntity?
    @Namespace private var namespace

    var body: some View {
        ZStack {
            if showDetails {
                DetailsView(showDetails: $showDetails, selectedPhoto: $selectedPhoto, namespace: namespace)
            } else { 
                WallView(showDetails: $showDetails, selectedPhoto: $selectedPhoto, namespace: namespace)
            }
        }
    }
}

struct WallMasterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WallMasterDetailView()
    }
}
