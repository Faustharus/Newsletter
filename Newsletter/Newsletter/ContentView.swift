//
//  ContentView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 22/11/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Choice = .everything
    
    enum Choice {
        case everything, topHeadlines
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NewsView()
                .tabItem {
                    Label("Générale", systemImage: "character.bubble.fill")
                }
                .tag(Choice.everything)
            
            HeadlineView()
                .tabItem {
                    Label("Gros-Titres", systemImage: "quote.bubble.fill")
                }
                .tag(Choice.topHeadlines)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NewsletterViewModelImpl(service: NewsletterServiceImpl()))
    }
}

