//
//  APIError.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 31.08.22.
//

import Foundation

enum APIError: Error {
    case NotFound
    case NetworkError(Error)
    case TemporaryError(Error)
    case InternalError(Error)
    
    init(clientError: ClientError) {
        switch clientError {
        case .HTTPClientError(let hTTPURLResponse):
            if hTTPURLResponse.statusCode == 404 { self = .NotFound }
            else { self = .InternalError(clientError) }
        case .HTTPServerError(_):
            self = .TemporaryError(clientError)
        case .DecodingError(_):
            self = .InternalError(clientError)
        case .InternalError(_):
            self = .InternalError(clientError)
        }
    }
}
