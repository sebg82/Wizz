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
    @Binding var selectedPhoto: PhotoEntity?
    var namespace: Namespace.ID
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        ZStack {
            ScrollView {
//                Text("\(todayDate)")
//                    .font(.system(size: 13, weight: .bold, design: .default))
//                    .foregroundColor(Color(.systemGray))
//                    .listRowSeparator(.hidden)
//
//                Text("Today")
//                    .font(.largeTitle)
//                    .foregroundColor(.primary)
//                    .listRowSeparator(.hidden)
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(vm.photos, id: \.self) { photo in
//                        Image(uiImage: photo.downloadImage() ?? UIImage())
                        Image("tezos")
                            .resizable()
                            .matchedGeometryEffect(id: "\(photo.id)", in: namespace)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .animation(.spring(response: 5.6, dampingFraction: 0.8))
                            .onTapGesture { selectedPhoto = photo }

//                        PhotoRow(photo: photo, namespace: namespace)
//                            .onTapGesture {
//                                selectedPhoto = photo
//                            }
                        
                        Text(photo.id)
                    }
//                    .listRowSeparator(.hidden)
                }
            }
//            .listStyle(.inset)
            .task {
               await vm.getPhotos()
            }
            .alert("Error", isPresented: $vm.hasError) {
            } message: {
                Text(vm.errorMessage)
            }
        }
    }
}

struct WallView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        WallView(selectedPhoto: .constant(nil), namespace: namespace)
    }
}
