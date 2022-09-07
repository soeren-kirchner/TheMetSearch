//
//  TheMetSearchTests.swift
//  TheMetSearchTests
//
//  Created by Sören Kirchner on 29.08.22.
//

import XCTest
@testable import TheMetSearch

class TheMetSearchTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
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
