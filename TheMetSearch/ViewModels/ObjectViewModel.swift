//
//  ObjectViewModel.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation

class ObjectViewModel: ObservableObject {
    
    @Published var loadingState: LoadingState<MetObject> = .loading
    let api: API
    
    init(api: API)  {
        self.api = api
    }
    
    func fetch(for id: Int) async {
        let result = await api.fetchObject(for: id)
        await MainActor.run { [weak self] in
            switch result {
            case .success(let object):
                debugPrint(object)
                self?.loadingState = .success(object)
            case .failure(let error):
                print(error)
                self?.loadingState = .error(error)
            }
        }
    }
}
