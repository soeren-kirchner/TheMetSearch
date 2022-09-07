//
//  PrimaryImageView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import SwiftUI

struct PrimaryImageView: View {
    
    @StateObject private var imageViewModel: ImageViewModel
    let url: URL?
    private let maxHeight = 400.0
        
    init(api: API, url: URL?) {
        self._imageViewModel = StateObject(wrappedValue: ImageViewModel(api: api))
        self.url = url
    }
    
    var body: some View {
        VStack {
            switch imageViewModel.loadingState {
            case .loading:
                ProgressView()
                    .scaleEffect(2)
                    .frame(height: maxHeight)
            case .error(_):
                ImageErrorView(height: 160)
                
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: min(maxHeight, maxHeight*image.size.height/image.size.width))
            }
        }
        .task {
            await imageViewModel.fetchImage(from: url)
        }
    }
}

//struct PrimaryImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        PrimaryImageView()
//    }
//}
