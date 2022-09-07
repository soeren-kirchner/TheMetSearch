//
//  GalleryView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 04.09.22.
//

import SwiftUI

struct GalleryView: View {
    
    let api: API
    let images: [String]
    @Binding var selectedImage: String?
    
    var body: some View {
        LazyVGrid(columns: [GridItem(spacing: 10), GridItem()], spacing: 10) {
            ForEach(images, id: \.self) { image in
                Color.background
                    .aspectRatio(1, contentMode: .fit)
                    .shadow(color: .black.opacity(0.15), radius: 3, x: -2, y: 2)
                    .overlay {
                        GalleryImageView(api: api, url: URL(string: image))
                            .padding()
                    }
                    .onTapGesture {
                        selectedImage = image
                    }
            }
        }
    }
}

extension String: Identifiable {
    public var id: String { self }
}

struct GalleryView_Previews_Wrapper: View {
    
    let api = API()
    
    @State var selectedImage: String?
    var body: some View {
        GalleryView(api: api, images: [
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-004.jpg",
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-003.jpg",
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-002.jpg",
            "https://images.metmuseum.org/CRDImages/ep/original/LC-EP_1993_132_suppl_CH-001.jpg"
        ], selectedImage: $selectedImage)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView_Previews_Wrapper()
    }
}
