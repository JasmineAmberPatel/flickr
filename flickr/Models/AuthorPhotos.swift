//
//  AuthorPhotos.swift
//  flickr
//
//  Created by Jasmine Patel on 18/10/2023.
//

import Foundation
// MARK: - AuthorPhotos
struct AuthorPhotos: Codable, Equatable {
    var authorPhotosList: AuthorPhotoList?
    
    static func == (lhs: AuthorPhotos, rhs: AuthorPhotos) -> Bool {
        return lhs.authorPhotosList == rhs.authorPhotosList
    }
}

// MARK: - Photos
struct AuthorPhotoList: Codable, Equatable {
    var photo: [PhotoElement]
}

