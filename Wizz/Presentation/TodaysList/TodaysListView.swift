//
//  TodaysListView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct TodaysListView: View {
    @StateObject var vm: TodaysListViewModel
    @State private var todayDate: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMM d yyyy"
        return dateFormatter.string(from: Date()).uppercased()
    } ()

    var body: some View {
        NavigationView {
            List {
                Text("\(todayDate)")
                    .font(.system(size: 13, weight: .bold, design: .default))
                    .foregroundColor(Color(.systemGray2))
                    .listRowSeparator(.hidden)
                ForEach(vm.photos) { photo in
                    ZStack {
                        NavigationLink(destination:
                            UserPhotosView(vm: UserPhotosViewModel())
                        ) {
                            EmptyView()
                        }
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                        
                        PhotoRow(photo: photo)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(.inset)
            .navigationBarTitle("Today")
        }
        .task {
           await vm.getPhotos()
        }
        .alert("Error", isPresented: $vm.hasError) {
        } message: {
            Text(vm.errorMessage)
        }
    }
}

struct TodaysListView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysListView(vm: TodaysListViewModel())
    }
}
