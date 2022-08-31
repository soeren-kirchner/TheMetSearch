//
//  Client.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation
import UIKit

class Client {
    
    public static func fetchData<Value>(for request: URLRequest, of type: Value.Type) async -> (Result<Value, ClientError>) where Value: Decodable {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return .failure(.NetworkError)
            }
            let result = try JSONDecoder().decode(type, from: data)
            return .success(result)
        } catch {
            return .failure(.UnknownError)
        }
    }
    
    public static func downloadImage(from url: URL) async -> Result<UIImage, ClientError> {
        if let image = ImageCacheManager.instance.get(url: url) { return .success(image) }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                  let image = UIImage(data: data)
            else {
                return .failure(.NetworkError)
            }
            ImageCacheManager.instance.add(image: image, for: url, until: getExpireDate(response: response))
            return .success(image)
        } catch  {
            return .failure(.UnknownError)
        }
    }
    
    private static func getExpireDate(response: HTTPURLResponse) -> Date {
        let defaultDate = Date(timeIntervalSinceNow: TheMetDefaults.ImageCache.maxAge)
        guard
            let cacheControl = response.value(forHTTPHeaderField: "Cache-Control"),
            let maxAgeValue = cacheControl.components(separatedBy: ",")
            .filter({ $0.contains("max-age") }).first?
            .components(separatedBy: "=").last?
            .trimmingCharacters(in: .whitespaces),
            let maxAge = TimeInterval(maxAgeValue)
        else { return defaultDate }
        print(maxAge)
        
        return min(Date(timeIntervalSinceNow: maxAge), defaultDate)
    }
    
}
