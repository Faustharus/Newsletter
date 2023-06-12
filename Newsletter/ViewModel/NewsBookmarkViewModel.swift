//
//  NewsBookmarkViewModel.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 08/06/2023.
//

import SwiftUI

@MainActor
final class NewsBookmarkViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published private(set) var bookmarked = [Article]()
    
    private let bookmarkDataStore = PlistDataStore<[Article]>(filename: "bookmarks")
    private let bookmarkMaxLimit = 10
    
    static let shared = NewsBookmarkViewModel()
    
    private init() {
        Task {
            await load()
        }
    }
    
    private func load() async {
        bookmarked = await bookmarkDataStore.load() ?? []
    }
    
    func isBookmarked(for article: Article) -> Bool {
        // Check if the article is bookmarked
        bookmarked.first(where: { article.id == $0.id }) != nil
    }
    
    func addBookmark(for article: Article) {
        // If the Article (ArticleDetailsView) is already bookmarked, exit the function
        guard !isBookmarked(for: article) else {
            return
        }
        
        bookmarked.insert(article, at: 0)
        bookmarksUpdated()
    }
    
    func removeBookmark(for article: Article) {
        // Get the Index
        guard let index = bookmarked.firstIndex(where: { article.id == $0.id }) else {
            return
        }
        
        bookmarked.remove(at: index)
        bookmarksUpdated()
    }
    
    private func bookmarksUpdated() {
        let bookmarks = self.bookmarked
        Task {
            await bookmarkDataStore.save(bookmarks)
        }
    }
    
}
