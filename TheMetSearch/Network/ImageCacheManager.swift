//
//  ImageCacheManager.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation
import UIKit

class ImageCacheManager {
    
    static let instance = ImageCacheManager()
    private init() {}
    
    private var cache: NSCache<NSString, WrappedImage> = {
        var cache = NSCache<NSString, WrappedImage>()
        cache.countLimit = TheMetDefaults.ImageCache.countLimit
        cache.totalCostLimit = TheMetDefaults.ImageCache.totalCostLimit
        return cache
    }()
    
    func add(image: UIImage, for url: URL, until expirationDate: Date) {
        let cacheObject = WrappedImage(image: image, expirationDate: expirationDate)
        let key = NSString(string: url.absoluteString)
        cache.setObject(cacheObject, forKey: key)
    }
    
    func get(url: URL) -> UIImage? {
        let key = NSString(string: url.absoluteString)
        guard let wrappedImage = cache.object(forKey: key) else { return nil }
        if wrappedImage.expirationDate < Date.now {
            cache.removeObject(forKey: key)
            return nil
        }
        return wrappedImage.image
    }
}

class WrappedImage {
    let image: UIImage
    let expirationDate: Date
    
    init(image: UIImage, expirationDate: Date) {
        self.image = image
        self.expirationDate = expirationDate
    }
}
