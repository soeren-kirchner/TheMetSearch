//
//  Client.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation
import UIKit

class Client {
    
    private static func fetch(request: URLRequest) async -> Result<Data, ClientError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.InternalError("not a HTTPURLResponse"))
            }
            switch response.statusCode {
            case 200..<300:
                return .success(data)
            case 400..<500:
                return .failure(.HTTPClientError(response))
            case 500..<600:
                return .failure(.HTTPServerError(response))
            default:
                return .failure(.InternalError("Unexpected HTTP status code: \(response.statusCode)"))
            }
        } catch {
            return .failure(.InternalError(error.localizedDescription))
        }
    }
    
    public static func fetchData<Value>(for request: URLRequest, of type: Value.Type) async -> Result<Value, ClientError> where Value: Decodable {
        
        let result = await fetch(request: request)
        switch result {
        case .failure(let error):
            return .failure(error)
        case .success(let data):
            do {
                let decodedJSON = try JSONDecoder().decode(type, from: data)
                return .success(decodedJSON)
            } catch let error as DecodingError {
                return .failure(.DecodingError(error))
            } catch {
                return .failure(.InternalError(error.localizedDescription))
            }
        }
    }
    
    public static func downloadImage(from url: URL) async -> Result<UIImage, ClientError> {
        if let image = ImageCacheManager.instance.get(url: url) { return .success(image) }
        let result = await fetch(request: URLRequest(url: url))
        switch result {
        case .success(let data):
            guard let newImage = UIImage(data: data) else { return .failure(.InternalError("Image data corrupted")) }
            return .success(newImage)
        case .failure(let error):
            return .failure(error)
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
