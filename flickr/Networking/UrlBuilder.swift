//
//  UrlBuilder.swift
//  flickr
//
//  Created by Jasmine Patel on 09/09/2023.
//

import Foundation

struct UrlBuilder {
    private var apiKey: String = ProcessInfo.processInfo.environment["FLICKR_API_KEY"] ?? ""
    private var host: String = "https://www.flickr.com"
    private var path: String = "/services/rest/"
    private var finalQueryString: String = "&safe_search=1&format=json&nojsoncallback=1"
    
    mutating func urlBuilder(method: String, params: String) -> String {
        return ("\(host)\(path)?method=\(method)&api_key=\(apiKey)\(params)\(finalQueryString)")
    }
}
