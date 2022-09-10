//
//  TheMetSearchMockClientAPITests.swift
//  TheMetSearchTests
//
//  Created by Sören Kirchner on 09.09.22.
//

import XCTest
@testable import TheMetSearch

class TheMetSearchMockClientAPITests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func createSampleResponse(statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: URL(string: "http://www.example.com")!,
                               statusCode: statusCode,
                               httpVersion: "HTTP/1.1",
                               headerFields: ["ETag" : "12345678"])!
    }
    
    func getResult(for statusCode: Int) async -> Result<MetObject, APIError> {
        let response = createSampleResponse(statusCode: statusCode)
        let data = "".data(using: .utf8)!
        let session = MockSession(data: data, urlResponse: response, error: nil)
        let api = API(client: Client(session: session))
        return await api.fetchObject(for: 1)
    }
    
    func test_TheMetSearchAPI_Result_shouldBe_SuccessWithCorrectMetObject() async {
        let sample = SampleData.Sample_436533()
        let response = createSampleResponse(statusCode: 200)
        let session = MockSession(data: sample.data, urlResponse: response, error: nil)
        let api = API(client: Client(session: session))
        
        let result = await api.fetchObject(for: 436533)
        
        switch result {
        case .success(let object):
            XCTAssertEqual(object, sample.expectedResult)
        case .failure(_):
            XCTFail("Should return .success(MetObject)")
        }
    }
    
    func test_TheMetSearchAPI_Result_shouldBe_InternalErrorHTTPClientError() async {
        let exceptions = [404]
        for statusCode in 400..<500 {
            if exceptions.contains(statusCode) { continue }
            let result = await getResult(for: statusCode)
            
            guard case .failure(.InternalError(let error as ClientError)) = result else {
                XCTFail("Expected to be InternalError")
                return
            }
            
            guard case .HTTPClientError = error else {
                XCTFail("Underlying Error is expected to be HTTPClientError")
                return
            }
        }
    }
    
    func test_TheMetSearchAPI_Result_shouldBe_InternalError() async {
        for statusCode in 500..<600 {
            let result = await getResult(for: statusCode)
            
            guard case .failure(.TemporaryError(let error as ClientError)) = result else {
                XCTFail("Expected to be TemporaryError")
                return
            }
            
            guard case .HTTPServerError = error else {
                XCTFail("Underlying Error is expected to be HTTPServerError")
                return
            }
        }
    }
    
    func test_TheMetSearchAPI_Result_shouldBe_FailureNotFound() async {
        let response = createSampleResponse(statusCode: 404)
        let data = "".data(using: .utf8)!
        let session = MockSession(data: data, urlResponse: response, error: nil)
        let api = API(client: Client(session: session))
        
        let result = await api.fetchObject(for: 1)
        
        guard case .failure(.NotFound) = result else {
            XCTFail("Expected to be NotFound Error")
            return
        }
    }
    
    func test_TheMetSearchAPI_Result_shouldBe_FailureInternalErrorDecodeError() async {
        let sample = SampleData.Sample_CorruptedJson()
        let response = createSampleResponse(statusCode: 200)
        let session = MockSession(data: sample.data, urlResponse: response, error: nil)
        let api = API(client: Client(session: session))
        
        let result = await api.fetchObject(for: 436533)

        guard case .failure(.InternalError(let error as ClientError)) = result else {
            XCTFail("Expected to be InternalError")
            return
        }

        guard case .DecodingError = error else {
            XCTFail("Expected to be DecodingError")
            return
        }
    }
}
