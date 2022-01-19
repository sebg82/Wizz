//
//  Image+Ext.swift
//  Wizz
//
//  Created by Sebastien Gohier on 17/01/2022.
//

import SwiftUI

extension Image {
    func resizedToFill(_ photo: PhotoEntity, namespace: Namespace.ID) -> some View {
        self
            .resizable()
            .matchedGeometryEffect(id: "\(photo.id)", in: namespace)
            .aspectRatio(1, contentMode: .fill)
    }
}
