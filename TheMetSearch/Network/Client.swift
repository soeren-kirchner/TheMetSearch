//
//  Client.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation
import UIKit

class Client: ClientProtocol {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    struct ClientResult {
        let data: Data
        let respone: HTTPURLResponse
    }
    
    private func fetch(request: URLRequest) async -> Result<ClientResult, ClientError> {
        do {
            let (data, response) = try await session.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.InternalError(GenericError(message: "not a HTTPURLResponse")))
            }
            switch response.statusCode {
            case 200..<300:
                return .success(ClientResult(data: data, respone: response))
            case 400..<500:
                return .failure(.HTTPClientError(response))
            case 500..<600:
                return .failure(.HTTPServerError(response))
            default:
                return .failure(.InternalError(GenericError(message: "Unexpected HTTP status code: \(response.statusCode)")))
            }
        } catch {
            return .failure(.InternalError(GenericError(message: error.localizedDescription)))
        }
    }
    
    func fetchData<Value>(for request: URLRequest, of type: Value.Type) async -> Result<Value, ClientError> where Value: Decodable {
        
        let result = await fetch(request: request)
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let clientResult):
            do {
                let decodedJSON = try JSONDecoder().decode(type, from: clientResult.data)
                return .success(decodedJSON)
            } catch let error as DecodingError {
                return .failure(.DecodingError(error))
            } catch {
                return .failure(.InternalError(GenericError(message: error.localizedDescription)))
            }
        }
    }
    
    func downloadImage(from url: URL) async -> Result<UIImage, ClientError> {
        if let image = ImageCacheManager.instance.get(url: url) { return .success(image) }
        let result = await fetch(request: URLRequest(url: url))
        switch result {
        case .success(let clientResult):
            guard let newImage = UIImage(data: clientResult.data) else { return .failure(.InternalError(GenericError(message: "Image data corrupted"))) }
            let expirationDate = Client.getExpireDate(response: clientResult.respone)
            ImageCacheManager.instance.add(image: newImage, for: url, until: expirationDate)
            return .success(newImage)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public static func getExpireDate(response: HTTPURLResponse) -> Date {
        let defaultDate = Date(timeIntervalSinceNow: TheMetDefaults.ImageCache.maxAge)
        guard
            let cacheControl = response.value(forHTTPHeaderField: "Cache-Control"),
            let maxAgeValue = cacheControl.components(separatedBy: ",")
            .filter({ $0.contains("max-age") }).first?
            .components(separatedBy: "=").last?
            .trimmingCharacters(in: .whitespaces),
            let maxAge = TimeInterval(maxAgeValue)
        else { return defaultDate }
        
        return min(Date(timeIntervalSinceNow: maxAge), defaultDate)
    }
}

protocol ClientProtocol {
    func fetchData<Value>(for request: URLRequest, of type: Value.Type) async -> Result<Value, ClientError> where Value: Decodable
    func downloadImage(from url: URL) async -> Result<UIImage, ClientError>
}

protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
