//
//  TheMetSearchMocks.swift
//  TheMetSearchTests
//
//  Created by Sören Kirchner on 09.09.22.
//

import Foundation
import SwiftUI
@testable import TheMetSearch

class MockClient<Value>: ClientProtocol {
    
    let result: Result<Value, ClientError>
    
    init(result: Result<Value, ClientError>) {
        self.result = result
    }
    
    func fetchData<Value>(for request: URLRequest, of type: Value.Type) async -> Result<Value, ClientError> where Value : Decodable {
        return self.result as! Result<Value, ClientError>
    }
    
    func downloadImage(from url: URL) async -> Result<UIImage, ClientError> {
        return result as! Result<UIImage, ClientError>
    }
}

class MockSession: URLSessionProtocol {
    
    let data: Data?
    let urlResponse: URLResponse?
    let error: Error?
    
    init(data: Data, urlResponse: URLResponse, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.error = error
    }
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return(data!, urlResponse!)
    }
}
