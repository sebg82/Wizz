//
//  DetailsView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 03/01/2022.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject var vm = DetailsViewModel()
    @Binding var selectedPhoto: PhotoEntity?
    var namespace: Namespace.ID
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        ZStack {
            scrollingPhotos
            closeButton
        }
//        ScrollView {
//            VStack {
//                Spacer()
//            }
//            .frame(maxWidth: .infinity)
//            .frame(height: 500)
////            .foregroundStyle(.black)
//            .background(
//
////                Image("tezos")
////                    .resizable()
////                    .frame(alignment: .center)
////                    .matchedGeometryEffect(id: selectedPhoto.id, in: namespace)
////                    .onTapGesture {
////                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
////                            selectedPhoto = nil
////                        }
////                    }
//                AsyncImage(url: URL(string: selectedPhoto.urlRegular)) { image in
//                    image
//                        .resizable()
//                        .frame(alignment: .center)
//                        .matchedGeometryEffect(id: selectedPhoto.id, in: namespace)
//                        .onTapGesture {
//                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
//                                selectedPhoto = nil
//                            }
//                        }
////                        .resizable()
////                        .frame(alignment: .center)
//////                        .aspectRatio(contentMode: .fill)
////                        .matchedGeometryEffect(id: selectedPhoto.id, in: namespace)
//                } placeholder: {
//                    Color.clear
//                }
//            )
////            .mask {
////                RoundedRectangle(cornerRadius: 30, style: .continuous)
////                    .matchedGeometryEffect(id: "mask", in:ContentView. namespace)
////            }
////            .overlay(
////                VStack(alignment: .leading, spacing: 12) {
////                    Text("SwiftUI")
////                        .font(.largeTitle.weight(.bold))
////                        .matchedGeometryEffect(id: "title", in: namespace)
////                        .frame(maxWidth: .infinity, alignment: .leading)
////                    Text("20 sections - 3 hours".uppercased())
////                        .font(.footnote.weight(.semibold))
////                        .matchedGeometryEffect(id: "subtitle", in: namespace)
////                    Text("dsdsadasdsada dasd das das dasd asdasd")
////                        .font(.footnote)
////                        .matchedGeometryEffect(id: "text", in: namespace)
////                    Divider()
////                    HStack {
////                        Image("views")
////                            .resizable()
////                            .frame(width: 26, height: 26)
////                            .cornerRadius(10)
////                            .padding(8)
////                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
//////                                    .strokeStyle(cornerRadius: 18)
////                        Text("guguuihi hiuhiuh ")
////                            .font(.footnote)
////                    }
////                }
////                    .padding(20)
////                    .background(
////                        Rectangle()
////                            .fill(.ultraThinMaterial)
////                            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
////                            .matchedGeometryEffect(id: "blur", in: namespace)
////                    )
////                    .offset(y: 250)
////                    .padding(20)
////            )
//        }
    } 
    
    var scrollingPhotos: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(vm.photos, id: \.self) { photo in
//                    AsyncImage(url: URL(string: photo.urlRegular)) { image in
//                        image.resizable()
//                            .frame(alignment: .center)
//                            .matchedGeometryEffect(id: "\(photo.id)", in: namespace)
//                    } placeholder: {
//                        Color.clear
//                    }
//                    .padding(5)
//                    .aspectRatio(1, contentMode: .fit)
//                    .animation(.spring(response: 5.6, dampingFraction: 0.8))

//                    Image(uiImage: photo.downloadImage() ?? UIImage())
                    Image("tezos")
                        .resizable()
                        .matchedGeometryEffect(id: "\(photo.id)", in: namespace)
                        .frame(width: 200, height: 100, alignment: .trailing)
                        .animation(.spring(response: 5.6, dampingFraction: 0.8))
                    Text(photo.id)
                }
            }
/*
            VStack {
                Text("Picture Statistics")
                    .font(.system(size: 17))
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                
                if let nbViews = vm.statistics?.views {
                    HStack {
                        Image("views")
                            .renderingMode(.template)
                        Text("\(nbViews) views")
                            .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    }
                }
                
                if let nbDownloads = vm.statistics?.downloads {
                    HStack {
                        Image("download")
                            .renderingMode(.template)
                        Text("\(nbDownloads) downloads")
                            .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    }
                }
            }
            .padding(20)
            .font(.system(size: 13, weight: .bold, design: .default))
            .foregroundColor(Color(.systemGray))
            .padding(.horizontal, 20)
*/
        }
//        .ignoresSafeArea()
        .task {
            if let selectedPhoto = selectedPhoto {
                await vm.getUserPhotos(of: selectedPhoto)
                await vm.getPhotoStatistics(selectedPhoto.id)
            }
        }
        .alert("Error", isPresented: $vm.hasError) {
        } message: {
            Text(vm.errorMessage)
        }
    }
    
    var closeButton: some View {
        Button {
            selectedPhoto = nil
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
//        .ignoresSafeArea()
    }
}

struct DetailsView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        DetailsView(selectedPhoto: .constant(.mock), namespace: namespace)
    }
}
