//
//  Person.swift
//  flickr
//
//  Created by Jasmine Patel on 10/09/2023.
//

import Foundation

// MARK: UserDetails
struct UserDetails: Codable, Equatable {
    var person: Person?
    
    static func == (lhs: UserDetails, rhs: UserDetails) -> Bool {
        return lhs.person == rhs.person
    }
}

// MARK: Person
struct Person: Codable, Equatable  {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String = ""
    var nsId: String = ""
    var iconServer: String = ""
    var iconFarm: Int = 0
    var username: Description = Description(content: "")
    var photosUrl: Description = Description(content: "")
    var profileUrl: Description = Description(content: "")
    var photos: Photos = Photos(firstDateTaken: Description(content: ""))
    
    var iconUrl: String {
        return "https://farm\(iconFarm).staticflickr.com/\(iconServer)/buddyicons/\(id).jpg"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case nsId = "nsid"
        case iconServer = "iconserver"
        case iconFarm = "iconfarm"
        case username
        case photosUrl = "photosurl"
        case profileUrl = "profileurl"
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
    var firstDateTaken: Description = Description(content: "")
    
    enum CodingKeys: String, CodingKey {
        case firstDateTaken = "firstdatetaken"
    }
}
