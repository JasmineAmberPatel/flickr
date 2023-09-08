//
//  PhotosViewModel.swift
//  flickr
//
//  Created by Jasmine Patel on 08/09/2023.
//

import Foundation

class PhotosViewModel: ObservableObject {
    private var apiKey: String = ProcessInfo.processInfo.environment["FLICKR_API_KEY"] ?? ""
    var text: String = "yorkshire"
    
    @Published var photos = Photos()
    
    
    init(apiKey: String = ProcessInfo.processInfo.environment["FLICKR_API_KEY"] ?? "",
         text: String = "yorkshire") {
        self.apiKey = apiKey
        self.text = text
        self.photos
    }
    
    
    enum ApiError: Error {
        case invalidUrl
        case invalidResponse
        case invalidData
    }
    
    func getPhotos() async throws -> Photos {
        let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(text)&safe_search=1&format=json&nojsoncallback=1"
        
        guard let url = URL(string: url) else { throw ApiError.invalidUrl }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Photos.self, from: data)
        } catch {
            throw ApiError.invalidData
        }
    }

}
