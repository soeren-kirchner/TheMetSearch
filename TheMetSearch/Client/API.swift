//
//  API.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation

struct API {
    
    private static let searchBaseUrl = "https://collectionapi.metmuseum.org/public/collection/v1/search"
    private static let objectBaseUrl = "https://collectionapi.metmuseum.org/public/collection/v1/objects"
    
    private static func searchUrl(for keyword: String) -> URL? {
        var components = URLComponents(string: searchBaseUrl)
        components?.queryItems = [URLQueryItem(name: "q", value: keyword)]
        return components?.url
    }
    
    private static func objectUrl(for id: Int) -> URL? {
        let url = URL(string: "\(objectBaseUrl)/\(String(id))")
        return url
    }

    private static func fetchData<Value>(from url: URL, of type: Value.Type) async -> Result<Value, APIError> where Value: Decodable {
        return await Client.fetchData(for: URLRequest(url: url), of: type)
            .flatMapError { clientError in
                    .failure(APIError(clientError: clientError))
            }
    }
    
    static func fetchObjects(for keyword: String) async -> Result<MetObjects, APIError> {
        guard let url = API.searchUrl(for: keyword) else {
            return .failure(.InternalError(GenericError(message: "Could not construct url for keyword \(keyword)")))
        }
        return await fetchData(from: url, of: MetObjects.self)
    }

    static func fetchObject(for id: Int) async -> Result<MetObject, APIError> {
        guard let url = API.objectUrl(for: id) else {
            return .failure(.InternalError(GenericError(message: "Could not construct url for keyword \(id)")))
        }
        return await fetchData(from: url, of: MetObject.self)
    }
}
