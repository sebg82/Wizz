//
//  WallMasterDetailView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct WallMasterDetailView: View {

    @State var selectedPhoto: PhotoEntity?
    @Namespace private var namespace
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        ZStack {
            if selectedPhoto != nil {
                DetailsView(selectedPhoto: $selectedPhoto, namespace: namespace)
            } else { 
                WallView(selectedPhoto: $selectedPhoto, namespace: namespace)
            }
        }
    }
}

struct WallMasterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WallMasterDetailView()
    }
}
