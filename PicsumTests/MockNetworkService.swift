//
//  MockNetworkService.swift
//  PicsumTests
//
//  Created by Madhu on 26/06/24.
//

import XCTest
import Combine
@testable import Picsum

// Mock Servic
class MockNetworkService: NetworkServiceAble {
    var fetchPhotosDataResult: Result<[PhotoData], Error>?
   
    func fetchPhotosData(page: Int,  completion: @escaping (Result<[PhotoData], Error>) -> Void) {
        if let result = fetchPhotosDataResult {
            completion(result)
        }
    }
}
