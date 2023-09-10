//
//  PhotosViewModel.swift
//  flickr
//
//  Created by Jasmine Patel on 08/09/2023.
//

import Foundation
import SwiftUI

class PhotosViewModel: ObservableObject {
    private var urlBuilder = UrlBuilder()
    private var flickrService: FlickrService
    
    @Published var flickrPhotos: Flickr

    init(urlBuilder: UrlBuilder = UrlBuilder(),
         flickrService: FlickrService = FlickrService(),
         flickrPhotos: Flickr = Flickr()) {
        self.urlBuilder = urlBuilder
        self.flickrService = flickrService
        self.flickrPhotos = flickrPhotos
    }
    
    @MainActor @discardableResult func searchPhotos(searchText: String) async throws -> Result<Flickr, APIError> {
        let url = urlBuilder.urlString(method: "flickr.photos.search", params: "&tags=tags&tag_mode=all&text=\(searchText)")
        
        switch try await flickrService.fetch(Flickr.self, url: url) {
        case .success(let photos):
            flickrPhotos = photos
            return Result.success(photos)
        case .failure(let error):
            return Result.failure(error)
        }
    }
}
