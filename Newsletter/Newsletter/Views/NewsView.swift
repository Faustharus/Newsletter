//
//  NewsView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 27/11/2021.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var vm: NewsletterViewModelImpl
    @State private var queryName: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List(vm.articles, id: \.title) { item in
                    HStack {
                        NavigationLink(destination: NewsDetailView(articles: item)) {
                            NewsRowView(articles: item)
                        }
                    }
                }
                .searchable(text: $queryName)
                .onSubmit(of: .search) {
                    Task {
                        await fetchCurrentNews(queryName: queryName)
                    }
                }
            }
            .navigationTitle("Newsletter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .environmentObject(NewsletterViewModelImpl(service: NewsletterServiceImpl()))
    }
}

// MARK: - Functions
extension NewsView {
    
    func fetchCurrentNews(queryName: String) async {
        let queryName = queryName.replacingOccurrences(of: " ", with: "+")
        await vm.fetchAllNews(queryName)
    }
    
}
