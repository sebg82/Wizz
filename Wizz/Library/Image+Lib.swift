//
//  Image+Library.swift
//  Wizz
//
//  Created by Sebastien Gohier on 17/01/2022.
//

import SwiftUI

struct LibraryContent: LibraryContentProvider {
    @Namespace static var namespace

    @LibraryContentBuilder
    var views: [LibraryItem] {
        LibraryItem(
            Image(uiImage: UIImage.fromCache(orUrl: PhotoEntity.mock.urlRegular))
                .resizedToFill(.mock, namespace: LibraryContent.namespace),
            title: "Image from url",
            category: .control
        )
    }
    
    @LibraryContentBuilder
    func modifiers(base: Image) -> [LibraryItem] {
        LibraryItem(
            base.resizedToFill(.mock, namespace: LibraryContent.namespace)
        )
    }
}
