//
//  GalleryImageView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 04.09.22.
//

import SwiftUI

struct GalleryImageView: View {

    @StateObject private var imageViewModel: ImageViewModel
    let url: URL?
    
    init(api: API, url: URL?) {
        self._imageViewModel = StateObject(wrappedValue: ImageViewModel(api: api))
        self.url = url
    }
    
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
    
    static let api = API()
    
    static var previews: some View {
        GalleryImageView(api: api, url: URL(string: "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-004.jpg"))
            .previewLayout(.sizeThatFits)
            .frame(width: 180, height: 180)
            
        GalleryImageView(api: api, url: URL(string: "Not a URL"))
            .previewLayout(.sizeThatFits)
            .frame(width: 180, height: 180)
    }
}
