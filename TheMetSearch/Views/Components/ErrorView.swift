//
//  ErrorView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 05.09.22.
//

import SwiftUI

struct ErrorView: View {
    
    let apiError: APIError
    
    var body: some View {
        switch apiError {
        case .NotFound:
            errorLine(message: "Not Found.")
        case .NetworkError(let underlyingError):
            errorLine(message: "A network error occured.", underlyingError: underlyingError)
        case .TemporaryError(let underlyingError):
            errorLine(message: "A temporary error occured. Please try again later.", underlyingError: underlyingError)
        case .InternalError(let underlyingError):
            errorLine(message: "Something unknown went wrong", underlyingError: underlyingError)
        }
    }
    
    func errorLine(message: String, underlyingError: ClientError? = nil) -> some View {
        VStack {
            Text("\(message)")
            #if DEBUG
            Text("\(underlyingError?.localizedDescription ?? "")")
                .font(.footnote)
            #endif
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(apiError: .NotFound)
    }
}
