//
//  ImageErrorView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 04.09.22.
//

import SwiftUI

struct ImageErrorView: View {
    
    let height: CGFloat
    
    var width: CGFloat { height * 1.4 }
    var fontSize: CGFloat { height / 8 }
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: height/2)
            Text("No image found")
                .font(.system(size: fontSize))
                .textCase(.uppercase)
            Spacer()
        }
        .opacity(0.4)
        .aspectRatio(contentMode: .fit)
        .frame(width: width, height: height)
    }
}

struct ImageErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ImageErrorView(height: 100)
            .previewLayout(.sizeThatFits)
            .padding(30)
        ImageErrorView(height: 200)
            .previewLayout(.sizeThatFits)
            .padding(30)
        ImageErrorView(height: 300)
            .previewLayout(.sizeThatFits)
            .padding(30)
    }
}
