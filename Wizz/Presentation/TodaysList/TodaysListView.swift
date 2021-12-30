//
//  TodaysListView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct TodaysListView: View {
//    @EnvironmentObject var modelData: ModelData
    @StateObject var vm = TodaysListViewModel()
    
    fileprivate func listRow(_ photo: PhotoEntity) -> some View {
        HStack{
            Text("\(photo.id)")
        }
    }

    var body: some View {
        List {
            ForEach(vm.photos){ item in
                listRow(item)
            }
        }
        .navigationTitle("Today")
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
        TodaysListView()/*.environmentObject(ModelData())*/
    }
}
