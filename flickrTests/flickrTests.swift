//
//  flickrTests.swift
//  flickrTests
//
//  Created by Jasmine Patel on 05/09/2023.
//

import XCTest
@testable import flickr

class FlickrServiceTests: XCTestCase {
    
    var sut: PhotosViewModel!
    var mockUrlBuilder: UrlBuilder!
    var mockFlickrService: MockFlickrService!
    
    override func setUp() {
        super.setUp()
        
        mockUrlBuilder = UrlBuilder()
        mockFlickrService = MockFlickrService()
        sut = PhotosViewModel(urlBuilder: mockUrlBuilder, flickrService: mockFlickrService)
    }

    override func tearDown() {
        sut = nil
        mockFlickrService = nil
        mockUrlBuilder = nil
        super.tearDown()
    }
    
    func testGetPhotosSuccess() async throws {
        let searchText = "yorkshire"
        
        let expectedPhotos = [
            PhotoElement(id: "1", owner: "owner1", secret: "secret1", server: "server1", farm: 1, title: "title1"),
            PhotoElement(id: "2", owner: "owner2", secret: "secret2", server: "server2", farm: 2, title: "title2")
        ]
        
        let expectedPhotosList = PhotosList(photo: expectedPhotos)
        let expectedPhotoSearch = PhotoSearch(photos: expectedPhotosList)
        
        mockFlickrService.setFetchResult(result: Result<PhotoSearch, APIError>.success(expectedPhotoSearch))

        do {
            switch try await sut.getPhotos(searchText: searchText) {
            case .success(let photos):
                XCTAssertEqual(photos, expectedPhotoSearch)
            case .failure(let error):
                XCTFail("Expecting success\nGot \(error)")
            }
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testGetPhotosFailure() async throws {
        let searchText = "yorkshire"
        let expectedError = APIError.mockError
        
        mockFlickrService.setFetchResult(result: Result<PhotoSearch, APIError>.failure(expectedError))
        
        do {
            switch try await sut.getPhotos(searchText: searchText) {
            case .success:
                XCTFail("Expecting failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error, expectedError, "Expected error to be \(expectedError), but got \(error)")
            }
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
}
