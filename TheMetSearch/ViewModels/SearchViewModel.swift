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
//    @Published var isSearching = false
    @Published var searchState: SearchState = .toFewCharacters
    
    private var searchTask: Task<(), Never>?
    
    func search() {
        if searchText.count < 3 {
            searchState = .toFewCharacters
            return
        }
        print("search called")
        print(searchText)
        searchTask?.cancel()
        searchState = .searching
        searchTask = Task {
            await fetch(for: searchText)
        }
        print("leave search")
    }
//    func search(for keyword: String, withImagesOnly: Bool = false) async {
//        searchTask?.cancel()
//    }
    
    private func fetch(for keyword: String) async {
        guard let url = API.search(for: keyword) else { return }
        let result = await Client.fetchData(for: URLRequest(url: url), of: Objects.self)
        if Task.isCancelled {
            print("Task canceled")
            return
        }
        DispatchQueue.main.async {
            switch result {
            case .success(let objects):
                self.searchState = .success
                self.objects = objects
            case .failure(_):
                self.searchState = .error
            }
        }
    }
}

enum SearchState {
    case toFewCharacters
    case searching
    case success
    case error
}
