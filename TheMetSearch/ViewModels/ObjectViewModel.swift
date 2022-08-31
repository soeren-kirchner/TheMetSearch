//
//  ObjectViewModel.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation

class ObjectViewModel: ObservableObject {
    
    @Published var loadingState: LoadingState<Object> = .loading
    
    func fetch(for id: Int) async {
        guard let url = API.object(for: id) else {
            loadingState = .error(.NetworkError)
            return
        }
        let result = await Client.fetchData(for: URLRequest(url: url), of: Object.self)
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let object):
                self?.loadingState = .success(object)
            case .failure(let error):
                print(error)
                self?.loadingState = .error(.NetworkError)
            }
        }
    }
}
