//
//  API.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation
import SwiftUI

/**
 The API is implemented to transform client errors into errors that are relevant to the UI or the user.
 The underlying errors are passed along for debugging purposes though.
*/
class API {
    
    private let searchBaseUrl = "https://collectionapi.metmuseum.org/public/collection/v1/search"
    private let objectBaseUrl = "https://collectionapi.metmuseum.org/public/collection/v1/objects"
    
    private let client: ClientProtocol
    
    init (client: ClientProtocol = Client()) {
        self.client = client
    }
    
    private func searchUrl(for keyword: String, hasImages: Bool, isOnView: Bool) -> URL? {
        var components = URLComponents(string: searchBaseUrl)
        var queryItems = [
            URLQueryItem(name: "q", value: keyword),
        ]
        if hasImages {
            queryItems.append(URLQueryItem(name: "hasImages", value: String(hasImages)))
        }
        if isOnView {
            queryItems.append(URLQueryItem(name: "isOnView", value: String(isOnView)))
        }
        components?.queryItems = queryItems
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
    
    func fetchObjects(for keyword: String, hasImages: Bool, isOnView: Bool) async -> Result<MetObjects, APIError> {
        guard let url = searchUrl(for: keyword, hasImages: hasImages, isOnView: isOnView) else {
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
