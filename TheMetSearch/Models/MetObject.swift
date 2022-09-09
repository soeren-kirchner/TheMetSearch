//
//  MetObject.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation

struct MetObject: Decodable, Equatable {
    let objectID: Int
    let title: String
    let artistDisplayName: String
    let department: String
    let objectName: String
    let culture: String
    let period: String
    let medium: String
    let dimensions: String
    let primaryImage: String
    let primaryImageSmall: String
    let additionalImages: [String]
}
