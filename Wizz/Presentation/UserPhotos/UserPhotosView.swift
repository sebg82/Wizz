//
//  UserPhotosView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 03/01/2022.
//

import SwiftUI

struct UserPhotosView: View {
    
    @StateObject var vm: UserPhotosViewModel
    @State var photo: PhotoEntity
    
    var namespace: Namespace.ID
    @Binding var showUserPhotos: Bool
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    var body: some View {
        ZStack {
            closeButton
            scrollingPhotos
        }
        .task {
            await vm.getUserPhotos(photo.user.username)
            vm.photos.insert(photo, at: 0)
            await vm.getPhotoStatistics(photo.id)
        }
        .alert("Error", isPresented: $vm.hasError) {
        } message: {
            Text(vm.errorMessage)
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
////                    .matchedGeometryEffect(id: photo.id, in: namespace)
////                    .onTapGesture {
////                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
////                            showUserPhotos.toggle()
////                        }
////                    }
//                AsyncImage(url: URL(string: photo.urlRegular)) { image in
//                    image
//                        .resizable()
//                        .frame(alignment: .center)
//                        .matchedGeometryEffect(id: photo.id, in: namespace)
//                        .onTapGesture {
//                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
//                                showUserPhotos.toggle()
//                            }
//                        }
////                        .resizable()
////                        .frame(alignment: .center)
//////                        .aspectRatio(contentMode: .fill)
////                        .matchedGeometryEffect(id: photo.id, in: namespace)
//                } placeholder: {
//                    Color.clear
//                }
//            )
////            .mask {
////                RoundedRectangle(cornerRadius: 30, style: .continuous)
////                    .matchedGeometryEffect(id: "mask", in: namespace)
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
                ForEach(vm.photos){ photo in
//                    AsyncImage(url: URL(string: photo.urlRegular)) { image in
//                        image.resizable()
//                            .frame(alignment: .center)
//                    } placeholder: {
//                        Color.clear
//                    }
//                    .padding(5)
//                    .aspectRatio(1, contentMode: .fit)
                    
                    Image("tezos")
                        .resizable()
                        .frame(alignment: .center)
//                        .padding(5)
                        .matchedGeometryEffect(id: photo.id, in: namespace)
                        .aspectRatio(1, contentMode: .fit)
                    Text(photo.id)
                }
            }

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
        }
//        .ignoresSafeArea()
    }
    
    var closeButton: some View {
        Button {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showUserPhotos.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .ignoresSafeArea()
    }
}

struct UserPhotosView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var photosUseCase = PhotosUseCase(source: UnsplashPhotosImpl(), cache: CachePhotosImpl())
    
    static var previews: some View {
        UserPhotosView(vm: UserPhotosViewModel(photosUseCase: photosUseCase),
                       photo: .mock,
                       namespace: namespace,
                       showUserPhotos: .constant(true))
    }
}
