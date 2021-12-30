//
//  SearchPhotosView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct SearchPhotosView: View {
    
    @StateObject var vm = SearchPhotosViewModel()

    var body: some View {
        List {
            ForEach(vm.photos){ item in
                HStack{
                    Text("\(item.id)")
                }
            }
        }
        .navigationTitle("Search")
        .task {
           await vm.getSearchPhotos("sky")
        }
        .alert("Error", isPresented: $vm.hasError) {
        } message: {
            Text(vm.errorMessage)
        }
    }
}

struct SearchPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPhotosView()
    }
}
