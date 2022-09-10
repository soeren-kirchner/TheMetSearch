//
//  SearchViewModel.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var objects = MetObjects(total: 0, objectIDs: [])
    @Published var searchState: SearchState = .toFewCharacters
    @Published var searchText = ""
    @Published var hasImages: Bool = false
    @Published var isOnView: Bool = false
    
    private var searchTask: Task<(), Never>?
    private var cancellables = Set<AnyCancellable>()
    
    let api: API

    init(api: API)  {
        self.api = api
        Publishers.CombineLatest3($searchText, $hasImages, $isOnView)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.search()
            }
            .store(in: &cancellables)
    }
    
    func search() {
        searchTask?.cancel()
        if searchText.count < TheMetDefaults.minimumInputCharachters {
            searchState = .toFewCharacters
            return
        }
        searchState = .searching
        searchTask = Task {
            await fetch()
        }
    }

    private func fetch() async {
        let result = await api.fetchObjects(for: searchText, hasImages: hasImages, isOnView: isOnView)
        if Task.isCancelled { return }
        await MainActor.run { [weak self] in
            switch result {
            case .success(let objects):
                self?.searchState = .success
                self?.objects = objects
            case .failure(let error):
                self?.searchState = .error(error)
            }
        }
    }
}

enum SearchState {
    case toFewCharacters
    case searching
    case success
    case error(APIError)
}
