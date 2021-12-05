//
//  NewsRowView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 23/11/2021.
//

import SwiftUI

struct NewsRowView: View {
    
    let articles: Article
    
    var body: some View {
        HStack {
            Images(imageString: articles.urlToImage, widths: 50, heights: 50, cornersRadius: 20)
            Text(articles.title)
                .font(.headline.weight(.thin))
        }
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowView(articles: Article.dummyNews.first!)
            .environmentObject(NewsletterViewModelImpl(service: NewsletterServiceImpl()))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
