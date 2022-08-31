//
//  Constants.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 30.08.22.
//

import Foundation

//extension TimeInterval {
//    static let cacheDefaultMaxAge: TimeInterval = 24 * 60 * 60
//}

enum TheMetDefaults {
    enum ImageCache {
        static let maxAge: TimeInterval = 24 * 60 * 60 // one day
        static let countLimit = 50
        static let totalCostLimit = 250 * 1024 * 1024 // 0.25
    }
    
}
