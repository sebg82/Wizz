//
//  TodaysListMasterDetailView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct TodaysListMasterDetailView: View {

    @State var selectedPhoto: PhotoEntity?
    @Namespace private var namespace
    
    var body: some View {
        ZStack {
            if selectedPhoto != nil {
                UserPhotosView(selectedPhoto: $selectedPhoto, namespace: namespace)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            selectedPhoto = nil
                        }
                    }
            } else { 
                TodaysListView(selectedPhoto: $selectedPhoto, namespace: namespace)
            }
        }
    }
}

struct TodaysListMasterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysListMasterDetailView()
    }
}
