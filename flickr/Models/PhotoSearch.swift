//
//  PhotoSearch.swift
//  flickr
//
//  Created by Jasmine Patel on 08/09/2023.
//

import Foundation

// MARK: PhotoSearch
struct PhotoSearch: Codable, Equatable {
    var photos: PhotosList?
    
    static func == (lhs: PhotoSearch, rhs: PhotoSearch) -> Bool {
        return lhs.photos == rhs.photos
    }
}

// MARK: PhotosList
struct PhotosList: Codable, Equatable {
    var photo: [PhotoElement]?
}

// MARK: PhotoElement
struct PhotoElement: Codable, Hashable {
    var id: String = ""
    var owner: String = ""
    var secret: String = ""
    var server: String = ""
    var farm: Int = 0
    var title: String = ""
    
    var photoUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
