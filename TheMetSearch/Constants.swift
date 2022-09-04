//
//  Constants.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 30.08.22.
//

import Foundation
import SwiftUI

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

extension Color {
    static let background = Color("background")
    static let searchFieldBackground = Color("searchFieldBackground")
    static let searchFieldBorder = Color("searchFieldBorder")
    static let searchFieldForeground = Color("searchFieldForeground")
    static let listCellBackground = Color("listCellBackground")
    static let listCellForeground = Color("listCellForeground")
    
}
