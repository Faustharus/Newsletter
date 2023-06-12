//
//  ArticleNewsView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 31/05/2023.
//

import SwiftUI

struct ArticleNewsView: View {
    
    @StateObject var articleNewsVM = NewsArticleViewModel()
    
    @State private var linkActive: Bool = false
    
    var body: some View {
        NavigationStack {
            ArticleListView(articles: articleNewsVM.articles)
                .navigationTitle(articleNewsVM.selectedCategory.categoryName).accessibilityAddTraits(.isHeader)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        // Switch the Category type of Articles displayed
                        menuCategory
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        // Switch the Language of Articles displayed
                        menuLanguage
                    }
                }
                .onAppear {
                    load()
                }
                .refreshable {
                    load()
                }
                .onChange(of: articleNewsVM.selectedCategory) { _ in
                    load()
                }
                .onChange(of: articleNewsVM.selectedLanguages) { _ in
                    load()
                }
        }
    }
}

struct ArticleNewsView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleNewsView()
    }
}

// MARK: - View Components
extension ArticleNewsView {
    
    private var menuCategory: some View {
        Menu {
            Picker("", selection: $articleNewsVM.selectedCategory) {
                ForEach(Category.allCases, id: \.self) {
                    Text($0.categoryName).tag($0)
                        .accessibilityLabel($0.categoryName)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityAddTraits(.isSelected)
                }
            }
        } label: {
            Image(systemName: "list.bullet")
                .accessibilityLabel("Category Selection")
                .accessibilityAddTraits(.isButton)
        }
    }
    
    private var menuLanguage: some View {
        Menu {
            Picker("", selection: $articleNewsVM.selectedLanguages) {
                ForEach(Language.allCases, id: \.self) {
                    Text($0.languageName).tag($0)
                        .accessibilityLabel($0.languageName)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityAddTraits(.isSelected)
                }
            }
        } label: {
            Image(systemName: "flag")
                .accessibilityLabel("Language Selection")
                .accessibilityAddTraits(.isButton)
        }
    }
}

// MARK: - Functions
extension ArticleNewsView {
    
    private func load() {
        Task {
            await articleNewsVM.loadArticles()
        }
    }
    
}
