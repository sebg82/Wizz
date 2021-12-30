//
//  TodaysList.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import SwiftUI

struct TodaysList: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TodaysList_Previews: PreviewProvider {
    static var previews: some View {
        TodaysList().environmentObject(ModelData())
    }
}
