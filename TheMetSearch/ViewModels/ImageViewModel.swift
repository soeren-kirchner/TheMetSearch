//
//  ImageViewModel.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation
import UIKit
import SwiftUI

class ImageViewModel: ObservableObject {
   
    @Published var loadingState: LoadingState<UIImage> = .loading
    
    func fetchImage(from url: URL?) async {
        guard let url = url else {
            await MainActor.run { [weak self] in
                self?.loadingState = .error(APIError.NotFound)
            }
            return
        }
        let result = await Client.downloadImage(from: url)
        await MainActor.run { [weak self] in
            switch result {
            case .success(let image):
                withAnimation {
                    self?.loadingState = .success(image)
                }
            case .failure(let error):
                self?.loadingState = .error(APIError(clientError: error))
            }
        }
    }
}
