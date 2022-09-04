//
//  GalleryImageView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 04.09.22.
//

import SwiftUI

struct GalleryImageView: View {

    @StateObject private var imageViewModel = ImageViewModel()
    let url: URL?
    
    var body: some View {
        VStack {
            switch imageViewModel.loadingState {
            case .loading:
                ProgressView()
            case .error(_):
                ImageErrorView(height: 160)
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
        .task {
            await imageViewModel.fetchImage(from: url)
        }
    }
}

struct GalleryImageView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryImageView(url: URL(string: "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-004.jpg"))
    }
}
