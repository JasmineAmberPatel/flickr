//
//  AuthorPhotos.swift
//  flickr
//
//  Created by Jasmine Patel on 18/10/2023.
//

import Foundation
// MARK: - AuthorPhotos
struct AuthorPhotos: Codable {
    var authorPhotosList: AuthorPhotoList?
}

// MARK: - Photos
struct AuthorPhotoList: Codable {
    var photo: [PhotoElement]
}

