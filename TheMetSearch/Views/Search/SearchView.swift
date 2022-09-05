//
//  SearchView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                header
                searchField
                resultArea
            }
            .padding(20)
            .background(
                Image("background")
                    .resizable()
                    .overlay(Material.thickMaterial)
                    .ignoresSafeArea()
            )
            .buttonStyle(.plain)
        }
    }
    
    var header: some View {
        VStack(alignment: .center) {
            Text("Search")
                .fontWeight(.semibold)
                .font(.system(size: 22, design: .default))
            Text("The Met")
                .font(.system(size: 40, design: .default))
                .fontWeight(.bold)
        }
        .padding(.bottom, 40)
    }
    
    var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .opacity(0.5)
                .padding(.leading, 5)
            
            ZStack(alignment: .leading) {
                Text("Placeholder")
                    .foregroundColor(.searchFieldPlaceholder)
                    .opacity(searchViewModel.searchText.isEmpty ? 1 : 0)
                TextField("", text: $searchViewModel.searchText)
                    .disableAutocorrection(true)
                    .onReceive(searchViewModel.$searchText
                        .debounce(for: 0.5, scheduler: RunLoop.main)) { _ in
                            print("received")
                            searchViewModel.search()
                        }
            }
            if case .searching = searchViewModel.searchState {
                ProgressView().tint(.gray)
            }
        }
        .foregroundColor(.searchFieldForeground)
        .font(.system(size: 22, design: .default))
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: .infinity)
                .fill(Color.searchFieldBackground)
        )
        .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.gray, lineWidth: 1))
    }
    
    var resultArea: some View {
        ScrollView  {
            switch searchViewModel.searchState {
            case .success, .searching:
                LazyVStack(spacing: 14) {
                    if let objectsIDs = searchViewModel.objects.objectIDs {
                        ForEach(objectsIDs, id: \.self) { objectId in
                            NavigationLink {
                                ObjectView(objectID: objectId)
                            } label: {
                                SearchViewListCell(objectId: objectId)
                            }
                        }
                    } else {
                        Text("No result")
                    }
                }
                .padding(20)
            case .toFewCharacters:
                Text("Please type at least \(TheMetDefaults.minimumInputCharachters) Characters in the Searchfield to perform a search.")
                    .padding(50)
                    .opacity(0.5)
            case .error(let error):
                ErrorView(apiError: error)
                    .padding(50)
            }
        }
        .padding(-20)
        .padding(.top, 30)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchView()
            SearchView()
                .preferredColorScheme(.dark)
        }
    }
}
