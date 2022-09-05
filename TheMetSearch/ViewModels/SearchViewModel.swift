//
//  SearchViewModel.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var objects = Objects(total: 0, objectIDs: [])
    @Published var searchText = ""
    @Published var searchState: SearchState = .toFewCharacters
    
    private var searchTask: Task<(), Never>?
    
    func search() {
        print("search called for \(searchText)")
        searchTask?.cancel()
        if searchText.count < TheMetDefaults.minimumInputCharachters {
            searchState = .toFewCharacters
            return
        }
        searchState = .searching
        searchTask = Task {
            await fetch(for: searchText)
        }
        print("leave search")
    }

    private func fetch(for keyword: String) async {
        let result = await API.fetchObjects(for: keyword)
        if Task.isCancelled {
            print("Task canceled")
            return
        }
        await MainActor.run {
            switch result {
            case .success(let objects):
                self.searchState = .success
                self.objects = objects
            case .failure(let error):
                self.searchState = .error(error)
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
