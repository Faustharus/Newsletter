//
//  NewsletterModel.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 22/11/2021.
//

import Foundation

struct NewsletterModel: Codable, Hashable {
    var articles: [Article]
}

struct Article: Codable, Hashable {
    var title: String
    var articleDescription: String
    var url: String
    var urlToImage: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case articleDescription = "description"
        case url
        case urlToImage
        case content
    }
}

