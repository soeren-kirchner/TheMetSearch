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
        
    var body: some View {
        VStack {
            switch imageViewModel.loadingState {
            case .loading:
                ProgressView()
                    .scaleEffect(2)
                    .frame(height: 350)
            case .error(_):
                EmptyView()
                    .frame(height: 350)
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(idealHeight: min(350, 350*image.size.height/image.size.width))
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
