//
//  AuthorPhotos.swift
//  flickr
//
//  Created by Jasmine Patel on 18/10/2023.
//

import Foundation

// MARK: AuthorPhotos
struct AuthorPhotos: Codable, Equatable {
    var photos: PhotosList?
    
    static func == (lhs: AuthorPhotos, rhs: AuthorPhotos) -> Bool {
        return lhs.photos == rhs.photos
    }
}
