//
//  Objects.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation

struct Objects: Decodable, Hashable {
    let total: Int
    let objectIDs: [Int]
}
