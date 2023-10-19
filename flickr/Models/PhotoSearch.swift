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
