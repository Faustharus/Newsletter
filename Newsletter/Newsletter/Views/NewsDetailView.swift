//
//  NewsDetailView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 24/11/2021.
//

import SwiftUI

struct NewsDetailView: View {
    
    var articles: Article
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    Images(imageString: articles.urlToImage, widths: 400, heights: 400, cornersRadius: 0)
                        .padding(.all, 5)
                    
                    Text("Review:")
                        .underline()
                        .font(.title3.weight(.semibold))
                        .padding(.vertical, 5)
                    VStack {
                        Text(articles.articleDescription)
                            .font(.subheadline.weight(.thin))
                            .multilineTextAlignment(.trailing)
                            .layoutPriority(0)
                            .padding(.horizontal, 5)
                    }
                    .padding(.all, 15)
                    
                    Divider()
                    
                    VStack {
                        Text(articles.content)
                            .font(.headline.weight(.bold))
                            .multilineTextAlignment(.center)
                            .layoutPriority(1)
                            .padding(.horizontal, 15)
                    }
                }
            }
        }
        .navigationTitle(articles.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    openURL(URL(string: articles.url)!)
                }) {
                    Image(systemName: "link.circle.fill")
                }
            }
        }
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        NewsDetailView(articles: Article.dummyNews.first!)
                .environmentObject(NewsletterViewModelImpl(service: NewsletterServiceImpl()))
        }
    }
}
