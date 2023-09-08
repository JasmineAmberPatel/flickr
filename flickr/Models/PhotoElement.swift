//
//  PhotoElement.swift
//  flickr
//
//  Created by Jasmine Patel on 06/09/2023.
//

import Foundation

struct PhotoElement: Codable {
    var id: String
    var owner: Owner
    var secret: String
    var server: String
    var farm: Int
    var title: String?
    var ispublic: Int?
    var isfriend: Int?
    var isfamily: Int?
    
    var photoUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
    enum Owner: String, Codable {
        case the144559712N04 = "144559712@N04"
        case the150500212N02 = "150500212@N02"
        case the188077531N05 = "188077531@N05"
        case the193275301N05 = "193275301@N05"
        case the197301540N02 = "197301540@N02"
        case the46874835N07 = "46874835@N07"
    }
}
