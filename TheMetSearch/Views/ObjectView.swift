//
//  ObjectView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import SwiftUI

struct ObjectView: View {
    
    @StateObject var objectViewModel = ObjectViewModel()
    let objectID: Int
    
    var body: some View {
        VStack {
            switch objectViewModel.loadingState {
            case .loading:
                ProgressView()
            case .success(let object):
                ObjectSuccessView(object: object)
            case .error(let error):
                Text("\(error.localizedDescription)")
            }
        }
        .task {
            await objectViewModel.fetch(for: objectID)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct ObjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        ObjectView()
//    }
//}
