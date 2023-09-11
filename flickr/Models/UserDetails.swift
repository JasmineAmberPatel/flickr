//
//  Person.swift
//  flickr
//
//  Created by Jasmine Patel on 10/09/2023.
//

import Foundation

// MARK: UserDetails
struct UserDetails: Codable {
    var person: Person?
    var stat: String = ""
}

// MARK: Person
struct Person: Codable {
    var id: String = ""
    var nsid: String = ""
    var iconserver: String = ""
    var iconfarm: Int = 0
    var username: Description = Description(content: "")
    var photosurl: Description = Description(content: "")
    var profileurl: Description = Description(content: "")
    var photos: Photos = Photos(firstdatetaken: Description(content: ""))
    
    var iconUrl: String {
        return "https://farm\(iconfarm).staticflickr.com/\(iconserver)/buddyicons\(id).jpg"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case nsid
        case iconserver
        case iconfarm
        case username
        case photosurl
        case profileurl
        case photos
    }
}

// MARK: Description
struct Description: Codable {
    var content: String = ""

    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}

// MARK: Photos
struct Photos: Codable {
    var firstdatetaken: Description = Description(content: "")
}
