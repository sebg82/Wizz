//
//  UserPhotosView.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct UserPhotosView: View {
    
    @StateObject var vm: UserPhotosViewModel
    
    var body: some View {
        List {
            ForEach(vm.photos){ item in
                HStack{
                    Text("\(item.id)")
                }
            }
        }
        .task {
           await vm.getUserPhotos("2DC3GyeqWjI")
        }
        .alert("Error", isPresented: $vm.hasError) {
        } message: {
            Text(vm.errorMessage)
        }
    }
}

struct UserPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        UserPhotosView(vm: UserPhotosViewModel())
    }
}

