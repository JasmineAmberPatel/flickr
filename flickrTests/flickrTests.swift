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
    
    func testGetUserDetailsSuccess() async throws {
        let userId = "someUserId"
        let expectedPerson = Person(id: "someId", username: Description(content: "username"))
        let expectedDetails = UserDetails(person: expectedPerson)
        
        mockFlickrService.setFetchResult(result: Result<UserDetails, APIError>.success(expectedDetails))
        
        do {
            switch try await sut.getUserDetails(userId: userId) {
            case .success(let userDetails):
                if let actualPerson = userDetails.person {
                    // Compare all properties of Person struct
                    XCTAssertEqual(actualPerson, expectedPerson)
                } else {
                    XCTFail("Person details should not be nil")
                }
            case .failure(let error):
                XCTFail("Expecting success\nGot \(error)")
            }
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testGetUserDetailsFailure() async throws {
        let userId = "someUserId"
        let expectedError = APIError.mockError
        
        mockFlickrService.setFetchResult(result: Result<UserDetails, APIError>.failure(expectedError))
        
        do {
            switch try await sut.getUserDetails(userId: userId) {
            case .success:
                XCTFail("Expecting failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error, expectedError, "Expected error to be \(expectedError), but got \(error)")
            }
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testGetImageDetailsSuccess() async throws {
        let photoId = "somePhotoId"
        let expectedDetails = Photo(id: "someId", title: Comments(content: "Title"), description: Comments(content: "Description"), dates: Dates(posted: "someTimestamp"), tags: Tags(tag: [Tag(id: "1", raw: "#name")]))
        
        mockFlickrService.setFetchResult(result: Result<ImageDetails, APIError>.success(ImageDetails(photo: expectedDetails)))
        
        do {
            switch try await sut.getImageDetails(photoId: photoId) {
            case .success(let details):
                // Compare the nested structures properly
                XCTAssertEqual(details.photo?.id, expectedDetails.id)
                XCTAssertEqual(details.photo?.title?.content, expectedDetails.title?.content)
                XCTAssertEqual(details.photo?.description?.content, expectedDetails.description?.content)
                XCTAssertEqual(details.photo?.dates?.posted, expectedDetails.dates?.posted)
                XCTAssertEqual(details.photo?.tags?.tag.first?.id, expectedDetails.tags?.tag.first?.id)
                XCTAssertEqual(details.photo?.tags?.tag.first?.raw, expectedDetails.tags?.tag.first?.raw)
            case .failure(let error):
                XCTFail("Expecting success\nGot \(error)")
            }
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testGetImageDetailsFailure() async throws {
        let photoId = "somePhotoId"
        let expectedError = APIError.mockError
        
        mockFlickrService.setFetchResult(result: Result<ImageDetails, APIError>.failure(expectedError))
        
        do {
            switch try await sut.getImageDetails(photoId: photoId) {
            case .success:
                XCTFail("Expecting failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error, expectedError, "Expected error to be \(expectedError), but got \(error)")
            }
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testGetPersonsPhotosSuccess() async throws {
        let userId = "someUserId"
        let expectedPhotos = [
            PhotoElement(id: "1", owner: "owner1", secret: "secret1", server: "server1", farm: 1, title: "title1"),
            PhotoElement(id: "2", owner: "owner2", secret: "secret2", server: "server2", farm: 2, title: "title2")
        ]
        let expectedPhotosList = PhotosList(photo: expectedPhotos)
        let expectedAuthorPhotos = AuthorPhotos(photos: expectedPhotosList)
        
        mockFlickrService.setFetchResult(result: Result<AuthorPhotos, APIError>.success(expectedAuthorPhotos))
        
        do {
            switch try await sut.getPersonsPhotos(userId: userId) {
            case .success(let photos):
                XCTAssertEqual(photos, expectedAuthorPhotos)
            case .failure(let error):
                XCTFail("Expecting success\nGot \(error)")
            }
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testGetPersonsPhotosFailure() async throws {
        let userId = "someUserId"
        let expectedError = APIError.mockError
        
        mockFlickrService.setFetchResult(result: Result<AuthorPhotos, APIError>.failure(expectedError))
        
        do {
            switch try await sut.getPersonsPhotos(userId: userId) {
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
