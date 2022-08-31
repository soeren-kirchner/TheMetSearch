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
    
    static func search(for keyword: String) -> URL? {
        var components = URLComponents(string: searchUrl)
        components?.queryItems = [URLQueryItem(name: "q", value: keyword)]
        return components?.url
    }
    
    static func object(for id: Int) -> URL? {
        let url = URL(string: "\(objectUrl)/\(String(id))")
        return url
//        return URL(string: String(id), relativeTo: url)
    }
}
