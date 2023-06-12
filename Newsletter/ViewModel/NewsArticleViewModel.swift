//
//  NewsArticleViewModel.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 31/05/2023.
//

import SwiftUI

@MainActor
final class NewsArticleViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var selectedCategory: Category = .general
    @Published var selectedLanguages: Language = .en
    
    private let newsAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general, selectedLanguages: Language = .en) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
    }
    
    func loadArticles() async {
        if Task.isCancelled { return } // Don't Initialize a Task unless a search is requested by the user
        phase = .empty
        do {
            let articles = try await newsAPI.fetch(from: selectedCategory, from: selectedLanguages)
            if Task.isCancelled { return } // Stop the Task after getting the articles
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return } // Stop the Task if an error is raised
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
    
    var articles: [Article] {
        // If current phase status is a match from the articles request
        if case let .success(articles) = phase {
            return articles
        } else {
            return []
        }
    }
}
