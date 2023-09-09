//
//  FlickrService.swift
//  flickr
//
//  Created by Jasmine Patel on 09/09/2023.
//

import Foundation

struct FlickrService {
    private var error: APIError

    func fetch<T: Decodable>(_ type: T.Type, url: String) async throws -> Result<T, APIError> {

        guard let url = URL(string: url) else { throw APIError.invalidUrl }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw APIError.badResponse(statusCode: response)
        }
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(T.self, from: data)
            return Result.success(decodedResponse)
        } catch {
            return Result.failure(APIError.parsing(error as? DecodingError))
        }
    }
}
   
