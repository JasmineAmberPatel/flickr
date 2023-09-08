//
//  PhotoElement.swift
//  flickr
//
//  Created by Jasmine Patel on 06/09/2023.
//

import Foundation

struct PhotoElement: Codable {
    var id: String = ""
    var secret: String = ""
    var server: String = ""
    var farm: Int = 0
    var title: String = ""
    
    var photoUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
}
