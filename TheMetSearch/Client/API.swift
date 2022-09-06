//
//  API.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation

struct API {
    
    private static let searchUrl = "https://collectionapi.metmuseum.org/public/collection/v1/search"
    private static let objectUrl = "https://collectionapi.metmuseum.org/public/collection/v1/objects"
    
    private static func search(for keyword: String) -> URL? {
        var components = URLComponents(string: searchUrl)
        components?.queryItems = [URLQueryItem(name: "q", value: keyword)]
        return components?.url
    }
    
    private static func object(for id: Int) -> URL? {
        let url = URL(string: "\(objectUrl)/\(String(id))")
        return url
    }

    private static func fetchData<Value>(from url: URL, of type: Value.Type) async -> Result<Value, APIError> where Value: Decodable {
        return await Client.fetchData(for: URLRequest(url: url), of: type)
            .flatMapError { clientError in
                    .failure(APIError(clientError: clientError))
            }
    }
    
    static func fetchObjects(for keyword: String) async -> Result<MetObjects, APIError> {
        guard let url = API.search(for: keyword) else {
            return .failure(.InternalError(nil))
        }
        return await fetchData(from: url, of: MetObjects.self)
//        return await Client.fetchData(for: URLRequest(url: url), of: Objects.self)
//            .flatMapError { clientError in
//                    .failure(APIError(clientError: clientError))
//            }
    }

    static func fetchObject(for id: Int) async -> Result<MetObject, APIError> {
        guard let url = API.object(for: id) else {
            return .failure(.InternalError(nil))
        }
        return await fetchData(from: url, of: MetObject.self)
//        return await Client.fetchData(for: URLRequest(url: url), of: MetObject.self)
//            .flatMapError { clientError in
//                    .failure(APIError(clientError: clientError))
//            }
    }
}
