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

extension Article {

    static let dummyNews: [Article] = [
        Article(title: "Hacking with Swift", articleDescription: "SwiftUI by Example is the world's largest collection of SwiftUI examples, tips, and techniques giving you almost 600 pages of hands-on code to help you build apps, solve problems, and understand how SwiftUI really works.", url: "https://www.hackingwithswift.com/100/swiftui", urlToImage: "https://www.hackingwithswift.com/img/paul.png", content: "SwiftUI by Example is the world's largest collection of SwiftUI examples, tips, and techniques giving you almost 600 pages of hands-on code to help you build apps, solve problems, and understand how SwiftUI really works."),
        Article(title: "Hacking with Swift", articleDescription: "SwiftUI by Example is the world's largest collection of SwiftUI examples, tips, and techniques giving you almost 600 pages of hands-on code to help you build apps, solve problems, and understand how SwiftUI really works.", url: "https://www.hackingwithswift.com/100/swiftui", urlToImage: "https://www.hackingwithswift.com/img/paul.png", content: "SwiftUI by Example is the world's largest collection of SwiftUI examples, tips, and techniques giving you almost 600 pages of hands-on code to help you build apps, solve problems, and understand how SwiftUI really works."),
        Article(title: "Hacking with Swift", articleDescription: "SwiftUI by Example is the world's largest collection of SwiftUI examples, tips, and techniques giving you almost 600 pages of hands-on code to help you build apps, solve problems, and understand how SwiftUI really works.", url: "https://www.hackingwithswift.com/100/swiftui", urlToImage: "https://www.hackingwithswift.com/img/paul.png", content: "SwiftUI by Example is the world's largest collection of SwiftUI examples, tips, and techniques giving you almost 600 pages of hands-on code to help you build apps, solve problems, and understand how SwiftUI really works.")
    ]

}
