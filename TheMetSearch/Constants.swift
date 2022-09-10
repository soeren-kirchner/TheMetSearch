//
//  Constants.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 30.08.22.
//

import Foundation
import SwiftUI

enum TheMetDefaults {
    static let minimumInputCharachters = 3
    enum ImageCache {
        static let maxAge: TimeInterval = 24 * 60 * 60 // one day
        static let countLimit = 50
        static let totalCostLimit = 250 * 1024 * 1024 // 0.25 GB
    }
}

extension Color {
    static let background = Color("Background")
    static let searchFieldBackground = Color("SearchFieldBackground")
    static let searchFieldBorder = Color("SearchFieldBorder")
    static let searchFieldForeground = Color("SearchFieldForeground")
    static let searchFieldPlaceholder = Color("SearchFieldPlaceholder")
    static let listCellBackground = Color("ListCellBackground")
    static let listCellForeground = Color("ListCellForeground")
    static let tint = Color("Tint")
}

extension Image {
    static let background = Image("Background")
}
