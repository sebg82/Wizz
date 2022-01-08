//
//  WallView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 03/01/2022.
//

import SwiftUI

struct WallView: View {
    
    @StateObject var vm = WallViewModel()
    @State private var todayDate: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMM d yyyy"
        return dateFormatter.string(from: Date()).uppercased()
    } ()
    @Binding var showDetails: Bool
    @Binding var selectedPhoto: PhotoEntity?
    var namespace: Namespace.ID

    var body: some View {
        ScrollView {
            Text("\(todayDate)")
                .font(.system(size: 13, weight: .bold, design: .default))
                .foregroundColor(Color(.systemGray))
                .listRowSeparator(.hidden)

            Text("Today")
                .font(.largeTitle)
                .foregroundColor(.primary)
                .listRowSeparator(.hidden)

            LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
                ForEach(vm.photos, id: \.self) { photo in
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
        .task {
           await vm.getPhotos()
        }
    }
}

struct WallView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        WallView(showDetails: .constant(false), selectedPhoto: .constant(nil), namespace: namespace)
    }
}
