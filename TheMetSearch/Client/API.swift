//
//  API.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation
import SwiftUI

class API {
    
    private let searchBaseUrl = "https://collectionapi.metmuseum.org/public/collection/v1/search"
    private let objectBaseUrl = "https://collectionapi.metmuseum.org/public/collection/v1/objects"
    
    private let client: Client
    
    init (client: Client? = nil) {
        if let client = client {
            self.client = client
        } else {
            self.client = Client()
        }
    }
    
    private func searchUrl(for keyword: String) -> URL? {
        var components = URLComponents(string: searchBaseUrl)
        components?.queryItems = [URLQueryItem(name: "q", value: keyword)]
        return components?.url
    }
    
    private func objectUrl(for id: Int) -> URL? {
        let url = URL(string: "\(objectBaseUrl)/\(String(id))")
        return url
    }

    private func fetchData<Value>(from url: URL, of type: Value.Type) async -> Result<Value, APIError> where Value: Decodable {
        return await client.fetchData(for: URLRequest(url: url), of: type)
            .flatMapError { clientError in
                    .failure(APIError(clientError: clientError))
            }
    }
    
    func fetchObjects(for keyword: String) async -> Result<MetObjects, APIError> {
        guard let url = searchUrl(for: keyword) else {
            return .failure(.InternalError(GenericError(message: "Could not construct url for keyword \(keyword)")))
        }
        return await fetchData(from: url, of: MetObjects.self)
    }

    func fetchObject(for id: Int) async -> Result<MetObject, APIError> {
        guard let url = objectUrl(for: id) else {
            return .failure(.InternalError(GenericError(message: "Could not construct url for keyword \(id)")))
        }
        return await fetchData(from: url, of: MetObject.self)
    }
    
    public func downloadImage(from url: URL) async -> Result<UIImage, ClientError> {
        return await client.downloadImage(from: url)
    }
}
