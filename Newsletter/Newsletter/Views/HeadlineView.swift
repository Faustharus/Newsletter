//
//  HeadlineView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 27/11/2021.
//

import SwiftUI

struct HeadlineView: View {
    @EnvironmentObject var vm: NewsletterViewModelImpl
    @State private var position: Int = 0
    
    let subClasses = ["business", "entertainment", "health", "science", "sports", "technology"]
    let frenchSubClasses = ["Affaires", "Divertissement", "Santé", "Science", "Sports", "Technologie"]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Picker("", selection: $position) {
                        ForEach(0 ..< subClasses.count) {
                            Text("\(frenchSubClasses[$0])")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.all, 5)
                    
                    ForEach(vm.articles, id: \.title) { item in
                        HStack {
                            NavigationLink(destination: NewsDetailView(articles: item)) {
                                NewsRowView(articles: item)
                            }
                        }
                    }
                }
                .refreshable {
                    await fetchHeadlinesNews(subClass: subClasses[position])
                }
            }
            .navigationTitle("Newsletter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HeadlineView_Previews: PreviewProvider {
    static var previews: some View {
        HeadlineView()
            .environmentObject(NewsletterViewModelImpl(service: NewsletterServiceImpl()))
    }
}

// MARK: - Functions
extension HeadlineView {
    
    func fetchHeadlinesNews(subClass: String) async {
        await vm.fetchHeadlineNews(subClass)
    }
    
}
