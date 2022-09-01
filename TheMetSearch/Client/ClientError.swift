//
//  ClientError.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation

enum ClientError: Error {
    case HTTPClientError(HTTPURLResponse)
    case HTTPServerError(HTTPURLResponse)
    case DecodingError(DecodingError)
    case InternalError(String)
}
