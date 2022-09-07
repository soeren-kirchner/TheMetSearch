//
//  ObjectSuccessView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import SwiftUI

struct ObjectSuccessView: View {
    
    let api: API
    let object: MetObject
    
    @State var selectedImage: String? = nil
   
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    headerImage
                    objectHeader
                    objectDetails
                    gallery
                        .padding(.bottom, 50)
                }
                .padding(.horizontal)
            }
            if let selectedImage = selectedImage {
                imageDetail(selectedImage: selectedImage)
            }
        }
    }
    
    var headerImage: some View {
        HStack {
            Spacer()
            PrimaryImageView(api: api, url: URL(string: object.primaryImageSmall))
                .onTapGesture {
                    self.selectedImage = object.primaryImageSmall
                }
            Spacer()
        }
    }
    
    var objectHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(object.title)
                .font(.system(size: 24))
                .fontWeight(.bold)
            Text(object.artistDisplayName)
                .font(.system(size: 20))
                .fontWeight(.medium)
        }
    }
    
    var objectDetails: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(cleanedDetails, id: \.self) { labelFieldPair in
                line(labelFieldPair[0], labelFieldPair[1])
            }
        }
    }
    
    var gallery: some View {
        VStack(alignment: .leading) {
            if !object.additionalImages.isEmpty {
                Text("Additional Images")
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .textCase(.uppercase)
                GalleryView(api: api, images: object.additionalImages, selectedImage: $selectedImage)
            }
        }
    }
    
    func line(_ label: String, _ content: String) -> some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.system(size: 14))
                .fontWeight(.light)
                .textCase(.uppercase)
            Text(content)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .lineLimit(2)
        }
    }

    var cleanedDetails: [[String]] {
        return [
            ["Object Name", object.objectName],
            ["Culture", object.culture],
            ["Period", object.period],
            ["Medium", object.medium],
            ["Dimensions", object.dimensions]
        ].filter{ !$0[1].isEmpty }
    }
    
    func imageDetail(selectedImage: String) -> some View {
        Color.background
            .ignoresSafeArea()
            .overlay {
                GalleryImageView(api: api, url: URL(string: selectedImage) )
            }
            .transition(.opacity)
            .onTapGesture {
                self.selectedImage = nil
            }
    }
}

struct ObjectSuccessView_Previews: PreviewProvider {
    
    static let api = API()
    
    static var previews: some View {
        Group {
            ObjectSuccessView(api: api, object: .example2)
            ObjectSuccessView(api: api, object: .example)
                .preferredColorScheme(.dark)
        }
    }
}
