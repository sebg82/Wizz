//
//  ModelData.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
//    @Published var photos: [Photo] = load("photoData.json")
//    @Published var profile = Profile.default
    var aaa: String = {
        let onSuccess: (([UPhoto]) -> ()) = { photos in
            print(photos)
        }
        UnsplashProvider<[UPhoto]>().load(
            "photos",
            query: [:],
            onError: { error in },
            onSuccess: onSuccess
        )
        return ""
    }()
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
