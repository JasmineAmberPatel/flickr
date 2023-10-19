//
//  PhotoElement.swift
//  flickr
//
//  Created by Jasmine Patel on 19/10/2023.
//

import Foundation

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
