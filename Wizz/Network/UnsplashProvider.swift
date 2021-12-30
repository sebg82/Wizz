//
//  UnsplashProvider.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

class UnsplashProvider<Element: Decodable> {

    func load<Element: Decodable>(_ stringUrl: String,
                                  query: [String:Any],
                                  onError: @escaping (String) -> (),
                                  onSuccess: @escaping (Element) -> ()) {
        
        let request = URLRequest(relativePath: stringUrl, queryParameters: query)
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                do {
                    if let object = try? JSONSerialization.jsonObject(with: data!, options: []),
                       let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
                       let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                        print(prettyPrintedString)
                    }
                    let object = try JSONDecoder().decode(Element.self, from: data!)
                    onSuccess(object)
                }
                catch {
                    return onError((error as NSError).userInfo.debugDescription)
                }
            }
        }).resume()
    }
}
