//
//  View+Ext.swift
//  Wizz
//
//  Created by Sebastien Gohier on 01/01/2022.
//

import SwiftUI

// Example of use:
//Button("Save to image") {
//    let image = someView.snapshot()
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//}
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
