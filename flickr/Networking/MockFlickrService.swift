//
//  MockFlickrService.swift
//  flickr
//
//  Created by Jasmine Patel on 12/09/2023.
//

import Foundation

class MockFlickrService: FlickrServiceProtocol {
    
    private var mockResult: Any?
    
    func setFetchResult<T: Decodable>(result: Result<T, APIError>) {
        self.mockResult = result
    }

    func fetch<T: Decodable>(_ type: T.Type, url: String) async throws -> Result<T, APIError> {
        if let result = mockResult as? Result<T, APIError> {
            return result
        } else {
            throw APIError.mockError
        }
    }
}
