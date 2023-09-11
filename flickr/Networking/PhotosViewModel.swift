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
    @Published var userDetails: UserDetails

    init(urlBuilder: UrlBuilder = UrlBuilder(),
         flickrService: FlickrService = FlickrService(),
         flickrPhotos: Flickr = Flickr(),
         userDetails: UserDetails = UserDetails()) {
        self.urlBuilder = urlBuilder
        self.flickrService = flickrService
        self.flickrPhotos = flickrPhotos
        self.userDetails = userDetails
    }
    
    @MainActor @discardableResult func getPhotos(searchText: String) async throws -> Result<Flickr, APIError> {
        let url = urlBuilder.urlString(method: "flickr.photos.search",
                                       params: "&tags=tags&tag_mode=all&text=\(searchText)&safe_search=1")
        
        switch try await flickrService.fetch(Flickr.self, url: url) {
        case .success(let photos):
            flickrPhotos = photos
            return Result.success(photos)
        case .failure(let error):
            return Result.failure(error)
        }
    }
    
    @MainActor @discardableResult func getUserDetails(userId: String) async throws -> Result<UserDetails, APIError> {
        let url = urlBuilder.urlString(method: "flickr.people.getInfo", params: "&user_id=\(userId)")
        switch try await flickrService.fetch(UserDetails.self, url: url) {
        case .success(let details):
            userDetails = details
            return Result.success(details)
        case .failure(let error):
            print(error)
            return Result.failure(error)
        }
    }
}
