//
//  LoadingState.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation

enum LoadingState<Value> {
    case loading
    case success(Value)
    case error(APIError)
}
