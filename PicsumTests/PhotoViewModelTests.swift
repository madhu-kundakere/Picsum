//
//  PhotoViewModelTests.swift
//  PicsumTests
//
//  Created by Madhu on 26/06/24.
//
//
import XCTest
import Combine
@testable import Picsum

class PhotoViewModelTests: XCTestCase {
    var viewModel: PhotoViewModel!
    var mockNetworkService: MockNetworkService!
   
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = PhotoViewModel(networkService: mockNetworkService)
    }
   
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
   
    func testFetchPhotosDataSuccess() {
        let photos = [PhotoData(id: "1", author: "Author1", width: 100, height: 100, url: "http://example.com", downloadURL: "http://example.com/download")]
        mockNetworkService.fetchPhotosDataResult = .success(photos)
       
        let expectation = self.expectation(description: "fetchPhotosData")
       
        // When
        viewModel.fetchPhotosData {
            XCTAssertEqual(self.viewModel.photos.count, photos.count)
            expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
    }
   
    func testFetchPhotosDataFailure() {
      
        mockNetworkService.fetchPhotosDataResult = .failure(NetworkError.failedToFetch)
       
        let expectation = self.expectation(description: "fetchPhotosData")
       
        viewModel.fetchPhotosData {
            XCTAssertEqual(self.viewModel.photos.count, 0)
            expectation.fulfill()
        }
       
        waitForExpectations(timeout: 1, handler: nil)
    }
}
