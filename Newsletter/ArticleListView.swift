//
//  ArticleListView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 31/05/2023.
//

import SwiftUI

struct ArticleListView: View {
    
    let articles: [Article]
    
    var body: some View {
        List {
            ForEach(articles, id: \.id) { article in
                ZStack {
                    ArticleRowView(article: article)
                        .accessibilityLabel("\(article.title)").accessibilityAddTraits(.isImage).accessibilityAddTraits(.isButton)
                    NavigationLink(value: article) {
                        EmptyView()
                    }
                    .opacity(0.0)
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.inset)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .navigationDestination(for: Article.self) { article in
            ArticleDetailsView(article: article)
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ArticleListView(articles: Article.localJSONData)
                .navigationTitle("Headlines")
        }
    }
}


