//
//  TheMetSearchTests.swift
//  TheMetSearchTests
//
//  Created by Sören Kirchner on 29.08.22.
//

import XCTest
@testable import TheMetSearch

class TheMetSearchTests: XCTestCase {
    
    func test_API_fetchObject_shouldReturn_Result_success () async {
        // Given
        let id = 436533
        let api = API()
        
        // When
        let result = await api.fetchObject(for: id)
        
        // Then
        switch result {
        case .failure(let error):
            XCTFail("Expected to be a success but got failure: \(error)")
        case .success(let object):
            XCTAssertEqual(object.title, "Shoes")
        }
    }
    
    func test_API_fetchObject_shouldReturn_Result_failure () async {
        // Given
        let id = -1
        let api = API()
        
        // When
        let result = await api.fetchObject(for: id)
        
        // Then
        switch result {
        case .failure(let error):
            switch error {
            case .NotFound:
                break
            default:
                XCTFail("Expected to be NotFound Error")
            }
        case .success(let object):
            XCTFail("Expected to be a failure but got success: \(object)")
        }
    }

}
