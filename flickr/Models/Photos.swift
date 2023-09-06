//
//  Photos.swift
//  flickr
//
//  Created by Jasmine Patel on 06/09/2023.
//

import Foundation

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [PhotoElement]
}
