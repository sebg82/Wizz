//
//  URLRequest+Extension.swift
//  Wizz
//
//  Created by Sebastien Gohier on 30/12/2021.
//

import Foundation

extension URLRequest {
    
    /**
     Creates and initializes a URLRequest with a path relative to the root URL, key/value parameters and send method.
     - parameter : relativePath The relative path added to the root path.
     - parameter : method GET/POST/PUT/DELETE, default GET
     - parameter : queryParameters array of keys/values appearing in a GET request
     */
    init(relativePath: String, queryParameters: [String: Any] = [:]) {
        
        var components = URLComponents(string: UnsplashConfiguration.apiURL.appendingPathComponent(relativePath).absoluteString)!
        components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        self.init(url: components.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        addValue("application/json", forHTTPHeaderField: "Accept")
        addValue("v1", forHTTPHeaderField: "Accept-Version")
        addValue("Client-ID \(UnsplashConfiguration.accessKey)", forHTTPHeaderField: "Authorization")
    }
    
}
