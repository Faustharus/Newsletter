//
//  ContentView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 28/05/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ArticleNewsView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                        .accessibilityLabel("News Page")
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .accessibilityAddTraits(.causesPageTurn)
                }
                .tag(0)
            
            ArticleSearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                        .accessibilityLabel("Search Page")
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .accessibilityAddTraits(.causesPageTurn)
                }
                .tag(1)
            
            ArticleBookmarkView()
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark")
                        .accessibilityLabel("Articles Bookmarked")
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .accessibilityAddTraits(.causesPageTurn)
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
