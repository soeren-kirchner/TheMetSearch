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
            VStack(alignment: .leading, spacing: 30) {
                headerImage
                objectHeader
                objectDetails
            }
            .padding(.horizontal)
        }
    }
    
    var headerImage: some View {
        HStack {
            Spacer()
            if let url = URL(string: object.primaryImageSmall) {
                PrimaryImageView(url: url)
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
}

struct ObjectSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ObjectSuccessView(object: .example2)
            ObjectSuccessView(object: .example)
                .preferredColorScheme(.dark)
        }
    }
}
