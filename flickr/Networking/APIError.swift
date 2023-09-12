//
//  APIError.swift
//  flickr
//
//  Created by Jasmine Patel on 09/09/2023.
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case parsing(DecodingError?)
    case unknown
    case badResponse(statusCode: URLResponse)
    case mockError
    
    // MARK: User error messages
    var errorMessage: String {
        switch self {
        case .invalidUrl, .parsing, .unknown:
            return "Sorry, something went wrong."
        case .badResponse(_):
            return "Sorry, the connection to our server failed."
        case .mockError: return ""
        }
    }
    
    // MARK: Error messages for debugging
    var description: String {
        //info for debugging
        switch self {
        case .invalidUrl: return "invalid URL"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .unknown: return "unknown error"
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        case .mockError: return "error from mock fetch request"
        }
    }
}
