//
//  ArticleBookmarkView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 08/06/2023.
//

import SwiftUI

struct ArticleBookmarkView: View {
    
    @EnvironmentObject var bookmarkVM: NewsBookmarkViewModel
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ArticleListView(articles: articles)
                .navigationTitle("Bookmarks").accessibilityLabel("Articles Bookmarked")
                .overlay(emptyBookmark(isEmpty: articles.isEmpty))
        }
        .searchable(text: $searchText)
    }
}

struct ArticleBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleBookmarkView()
            .environmentObject(NewsBookmarkViewModel.shared)
    }
}

// MARK: - Functions & Computed Properties
extension ArticleBookmarkView {
    
    var articles: [Article] {
        if searchText.isEmpty {
            return bookmarkVM.bookmarked
        }
        return bookmarkVM.bookmarked
            .filter {
                $0.title.contains(searchText) ||
                $0.source.name.contains(searchText) ||
                $0.descriptionText.contains(searchText)
            }
    }
    
}


// MARK: - View Components
extension ArticleBookmarkView {
    
    @ViewBuilder
    func emptyBookmark(isEmpty: Bool) -> some View {
        if isEmpty {
            VStack {
                Text("⚠️ This is where you'll find all of your bookmarked articles. \nFor a limit of 10 articles stored ⚠️")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 10)
        }
    }
    
}
