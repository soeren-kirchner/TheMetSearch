//
//  SearchView.swift
//  TheMetSearch
//
//  Created by Sören Kirchner on 29.08.22.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var searchViewModel = SearchViewModel()
    @State var searchText = "Baldly"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading, 5)
                    TextField("Enter your Keyword", text: $searchViewModel.searchText)
                        .disableAutocorrection(true)
                        .onReceive(searchViewModel.$searchText.debounce(for: 0.5, scheduler: RunLoop.main)) { _ in
                            print("received")
                            searchViewModel.search()
                        }
                }
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
//                Button("Search") {
//                    Task {
//                        await searchViewModel.fetch(for: searchText)
//                    }
//                }
                
                List {
                    ForEach(searchViewModel.objects.objectIDs, id: \.self) { objectId in
                        NavigationLink {
                            ObjectView(objectID: objectId)
                        } label: {
                            Text(String("\(objectId)"))
                        }
                    }
                }
                .navigationTitle("Search TheMet")
            }
            .padding()
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
