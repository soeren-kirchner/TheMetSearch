//
//  GalleryDetailView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 04.09.22.
//

import SwiftUI

struct GalleryDetailView: View {
    
    @Binding var selectedImage: String?
    
    var body: some View {
        VStack {
            if let image = selectedImage {
                GalleryImageView(url: URL(string: image) )
                    .onTapGesture {
                        selectedImage = nil
                    }
            }
        }
    }
}

//struct GalleryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GalleryDetailView()
//    }
//}
