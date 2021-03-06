//
//  PhotoRow.swift
//  Wizz
//
//  Created by Sebastien Gohier on 31/12/2021.
//

import SwiftUI

struct PhotoRow: View {
    var photo: PhotoEntity
    @State var photoImage: UIImage = UIImage()
    var namespace: Namespace.ID

    var body: some View {
        photoImageView
            .overlay { photoInfos }
            .padding(20)
    }
    
    var photoImageView: some View {
        Image(uiImage: photoImage)
            .resizedToFill(photo, namespace: namespace)
            .cornerRadius(15)
            .shadow(color: .gray, radius: 5)
//                .animation(.spring(response: 5.6, dampingFraction: 0.8))
            .task {
                photoImage = UIImage.fromCache(orUrl: photo.urlRegular)
            }
    }
    
    var photoInfos: some View {
        VStack {
            Spacer()
            HStack {
                Image(uiImage: UIImage.fromCache(orUrl: photo.user.profileImageMedium))
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .cornerRadius(25)
                    .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(.white, lineWidth: 2))

                VStack(alignment: .leading) {
                    Text("\(photo.user.username)")
                    Text("\(photo.likes) likes")
                }
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 2)
            }
            .padding(10)
        }
    }
}

struct PhotoRow_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        PhotoRow(photo: .mock, namespace: namespace)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
