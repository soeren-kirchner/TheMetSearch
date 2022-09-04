//
//  SearchViewListCell.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 02.09.22.
//

import SwiftUI

struct SearchViewListCell: View {
    
    let objectId: Int
    
    var body: some View {
        HStack {
            Text(String("\(objectId)"))
                .padding(.leading, 5)
            Spacer()
            Image(systemName: "arrow.forward.circle.fill")
        }
        .font(.system(size: 22))
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: .infinity)
                .fill(Color.listCellBackground.opacity(0.85))
                .shadow(color: .black.opacity(0.15), radius: 3, x: -2, y: 2)
        )
    }
}

struct SearchViewListCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchViewListCell(objectId: 123456)
            SearchViewListCell(objectId: 123456)
                .preferredColorScheme(.dark)
        }
    }
}
