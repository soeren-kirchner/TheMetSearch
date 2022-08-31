//
//  ObjectSuccessView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import SwiftUI

struct ObjectSuccessView: View {
    
    let object: Object
    
    var body: some View {
        ScrollView {
            VStack {
    //            if let url = URL(string: object.primaryImage) {
    //                AsyncImage(url: url)
    //                    .frame(height: 400)
    //                    .clipped()
    //            }
                if let url = URL(string: object.primaryImage) {
                    PrimaryImageView(url: url)
                }
                Text(object.primaryImage)
                Text(object.title)
            }
        }
    }
}

//struct ObjectSuccessView_Previews: PreviewProvider {
//    static var previews: some View {
//        ObjectSuccessView()
//    }
//}
