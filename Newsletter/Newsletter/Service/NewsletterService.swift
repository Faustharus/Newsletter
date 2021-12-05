//
//  NewsletterService.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 05/12/2021.
//

import Foundation

protocol NewsletterService {
    func fetchAllNews(_ query: String) async throws -> [Article]
    func fetchHeadlineNews(_ category: String) async throws -> [Article]
}

final class NewsletterServiceImpl: NewsletterService {
    
    func fetchAllNews(_ query: String) async throws -> [Article] {
        let urlSession = URLSession.shared
        let url = URL(string: APIConstant.baseAllURL.appending("&q=\(query)"))
        let (data, _) = try await urlSession.data(from: url!)
        let array = try JSONDecoder().decode(NewsletterModel.self, from: data)
        return array.articles
    }
    
    func fetchHeadlineNews(_ category: String) async throws -> [Article] {
        let urlSession = URLSession.shared
        let url = URL(string: APIConstant.baseHeadlineURL.appending("&category=\(category)"))
        let (data, _) = try await urlSession.data(from: url!)
        let array = try JSONDecoder().decode(NewsletterModel.self, from: data)
        return array.articles
    }
    
}
