//
//  BackgroundView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 07.09.22.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image.background
            .resizable()
            .overlay(Material.regularMaterial)
            .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
