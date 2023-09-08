//
//  PhotoElement.swift
//  flickr
//
//  Created by Jasmine Patel on 06/09/2023.
//

import Foundation

struct PhotoElement: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    
    var photoUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
