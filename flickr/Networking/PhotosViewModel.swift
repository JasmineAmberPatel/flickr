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
    private var flickrService: FlickrServiceProtocol
    
    @Published var photoSearch: PhotoSearch
    @Published var userDetails: UserDetails
    @Published var imageDetails: ImageDetails

    init(urlBuilder: UrlBuilder = UrlBuilder(),
         flickrService: FlickrServiceProtocol = FlickrService(),
         photoSearch: PhotoSearch = PhotoSearch(),
         userDetails: UserDetails = UserDetails(),
         imageDetails: ImageDetails = ImageDetails()) {
        self.urlBuilder = urlBuilder
        self.flickrService = flickrService
        self.photoSearch = photoSearch
        self.userDetails = userDetails
        self.imageDetails = imageDetails
    }
    
    @MainActor @discardableResult func getPhotos(searchText: String) async throws -> Result<PhotoSearch, APIError> {
        let url = urlBuilder.urlString(method: "flickr.photos.search",
                                       params: "&tags=tags&tag_mode=all&text=\(searchText)&safe_search=1")
        
        switch try await flickrService.fetch(PhotoSearch.self, url: url) {
        case .success(let photos):
            photoSearch = photos
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
    
    @MainActor @discardableResult func getImageDetails(photoId: String) async throws -> Result<ImageDetails, APIError> {
        let url = urlBuilder.urlString(method: "flickr.photos.getInfo", params: "&photo_id=\(photoId)")
        switch try await flickrService.fetch(ImageDetails.self, url: url) {
        case .success(let details):
            imageDetails = details
            return Result.success(details)
        case .failure(let error):
            print(error)
            return Result.failure(error)
        }
    }
}
