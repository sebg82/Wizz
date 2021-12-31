//
//  PhotoRow.swift
//  Wizz
//
//  Created by Sebastien Gohier on 31/12/2021.
//

import SwiftUI

struct PhotoRow: View {
    var photo: PhotoEntity

    var body: some View {
        ZStack{

            AsyncImage(url: URL(string: photo.urlRegular)) { image in
                image.resizable()
                    .frame(alignment: .center)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            } placeholder: {
                Color.clear
            }
            .padding(10)

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
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .bottomLeading)
                        Text("\(photo.likes) likes")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .bottomLeading)
                    }
                }
                .padding(10)
            }
            .padding(10)
        }
        .clipped()
        .aspectRatio(1, contentMode: .fit)
        .padding(.vertical, 20)
    }
}

struct PhotoRow_Previews: PreviewProvider {
    static var photo = PhotoEntity(id: "g2E2NQ5SWSU",
                                   user: UserEntity(id: "2DC3GyeqWjI",
                                                    username: "xps",
                                                    profileImageMedium: "https://images.unsplash.com/profile-1600096866391-b09a1a53451aimage?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"),
                                   urlRegular: "https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODcwNjZ8MXwxfGFsbHwxfHx8fHx8Mnx8MTY0MDg2NTgwNQ&ixlib=rb-1.2.1&q=80&w=1080",
                                   likes: 2356)
    static var previews: some View {
        PhotoRow(photo: photo)
            .previewLayout(.fixed(width: 300, height: 400))
    }
}
