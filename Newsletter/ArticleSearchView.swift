//
//  ArticleSearchView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 03/06/2023.
//

import SwiftUI

struct ArticleSearchView: View {
    
    @StateObject var searchVM = NewsSearchViewModel.shared
    
    var body: some View {
        NavigationStack {
            ArticleListView(articles: searchVM.articles)
                .overlay(idleSearchView)
                .navigationTitle("Search").accessibilityAddTraits(.isHeader)
                .searchable(text: $searchVM.searchText).accessibilityAddTraits(.isSearchField)
                .onSubmit(of: .search, search).accessibilityAddTraits(.isKeyboardKey).accessibilityAddTraits(.isButton)
                .onChange(of: searchVM.searchText) { newValue in
                    if newValue.isEmpty {
                        searchVM.phase = .empty
                    }
                }
                .refreshable {
                    loadArticles()
                }
        }
    }
}

struct ArticleSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ArticleSearchView()
                .navigationTitle("Search")
        }
        
    }
}


// MARK: - Functions
extension ArticleSearchView {
    
    private func loadArticles() {
        Task {
            await searchVM.loadSearchedArticles()
        }
    }
    
    private func search() {
        let query = searchVM.searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !query.isEmpty {
            searchVM.addEntry(query)
        }
        loadArticles()
    }
    
}

// MARK: - View Components
extension ArticleSearchView {
    
    @ViewBuilder
    private var idleSearchView: some View {
        switch searchVM.phase {
            case .empty:
                if !searchVM.searchText.isEmpty {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray.opacity(0.4).shadow(.drop(color: .black, radius: 5, x: 2, y: 2)))
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.06)
                        VStack {
                            ProgressView()
                            Text("Searching...")
                                .font(.system(size: 14, weight: .medium, design: .serif))
                        }
                    }
                } else {
                    VStack {
                        Picker("", selection: $searchVM.searchIn) {
                            ForEach(Choice.allCases, id: \.self) { item in
                                Text("\(item.searchInCategory)").tag(item)
                                    .accessibilityLabel(item.searchInCategory)
                                    .accessibilityAddTraits(.isSelected)
                                    .accessibilityAddTraits(.isButton)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 10)
                        
                        ZStack {
                            
                            EntriesSearchListView(searchVM: searchVM) { newValue in
                                searchVM.searchText = newValue
                                search()
                            }
                            
                        }
                    }
                }
                
            case .success(let articles) where articles.isEmpty:
                if searchVM.searchIn == .names {
                    SearchFailView(sfSymbols: "magnifyingglass", mainMassage: "No articles has been recently posted about \(searchVM.searchText)", renderingMode: .palette, renderingColorFirst: .blue, renderingColorSecond: .white)
                } else {
                    SearchFailView(sfSymbols: "magnifyingglass", mainMassage: "No articles has been recently posted by \(searchVM.searchText)", renderingMode: .palette, renderingColorFirst: .blue, renderingColorSecond: .white)
                }
                
            case .failure(let error):
                SearchFailView(sfSymbols: "exclamationmark.triangle.fill", mainMassage: "Failure: \(error.localizedDescription)", renderingMode: .multicolor, renderingColorFirst: .clear, renderingColorSecond: .clear)
                
            default: EmptyView()
        }
    }
    
}
