//
//  PhotoRow.swift
//  Wizz
//
//  Created by Sebastien Gohier on 31/12/2021.
//

import SwiftUI

struct PhotoRow: View {
    var photo: PhotoEntity
    var namespace: Namespace.ID

    var body: some View {
        VStack {
            Spacer()
            HStack {
                AsyncImage(url: URL(string: photo.user.profileImageMedium)) { image in
                    image
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .cornerRadius(25)
                        .overlay(RoundedRectangle(cornerRadius: 25)
                                    .stroke(.white, lineWidth: 2))

                } placeholder: {
                    Color.clear
                }

                VStack {
                    Text("\(photo.user.username)")
                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    Text("\(photo.id) likes")
                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                }
                .font(.footnote.weight(.bold))
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 2)
            }
            .padding(10)
        }
        .background(
//            Image(uiImage: photo.downloadImage() ?? UIImage())
////            Image("tezos")
//                .resizable()
//                .frame(alignment: .center)
//                .cornerRadius(15)
//                .shadow(radius: 5)
//                .matchedGeometryEffect(id: photo.id, in: namespace)

            AsyncImage(url: URL(string: photo.urlRegular)) { image in
                image
                    .resizable()
                    .frame(alignment: .center)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .matchedGeometryEffect(id: photo.id, in: namespace)
            } placeholder: {
                Color.clear
            }
        )
//        .mask {
//            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                .matchedGeometryEffect(id: "mask", in: namespace)
//        }
        .aspectRatio(1, contentMode: .fill)
    }
}

struct PhotoRow_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        PhotoRow(photo: .mock, namespace: namespace)
            .previewLayout(.fixed(width: 300, height: 400))
    }
}
