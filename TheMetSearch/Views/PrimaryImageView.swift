//
//  PrimaryImageView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import SwiftUI

struct PrimaryImageView: View {
    
    @StateObject private var imageViewModel = ImageViewModel()
    let url: URL
    let maxHeight = 400.0
        
    var body: some View {
        VStack {
            switch imageViewModel.loadingState {
            case .loading:
                ProgressView()
                    .scaleEffect(2)
                    .frame(height: maxHeight)
            case .error(_):
                EmptyView()
                    .frame(height: maxHeight)
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
