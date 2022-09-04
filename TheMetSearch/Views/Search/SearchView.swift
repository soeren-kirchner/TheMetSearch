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
            
            TextField("Enter your Keyword", text: $searchViewModel.searchText)
                .tint(.green)
                .tint(.searchFieldBorder)
                .disableAutocorrection(true)
                .onReceive(searchViewModel.$searchText
                    .debounce(for: 0.5, scheduler: RunLoop.main)) { _ in
                        print("received")
                        searchViewModel.search()
                    }
            if searchViewModel.searchState == .searching {
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
        ScrollView {
            LazyVStack(spacing: 14) {
                ForEach(searchViewModel.objects.objectIDs, id: \.self) { objectId in
                    NavigationLink {
                        ObjectView(objectID: objectId)
                    } label: {
                        SearchViewListCell(objectId: objectId)
                    }
                }
            }
            .padding(20)
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
