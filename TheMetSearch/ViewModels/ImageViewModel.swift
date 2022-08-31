//
//  ImageViewModel.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation
import UIKit

class ImageViewModel: ObservableObject {
   
    @Published var loadingState: LoadingState<UIImage> = .loading
    
    func fetchImage(from url: URL) async {
        let result = await Client.downloadImage(from: url)
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let image):
                self?.loadingState = .success(image)
            case .failure(_):
                self?.loadingState = .error(.NetworkError)
            }
        }
    }
}
