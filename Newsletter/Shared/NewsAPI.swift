//
//  NewsAPI.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 31/05/2023.
//

import Foundation

struct NewsAPI {
    
    static let shared = NewsAPI()
    private init() {}
    
    private let apiKey = NewsAPIKey.apiKey
    private let session = URLSession.shared
    private let decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
    
    private func generateNewsURL(from category: Category, from language: Language) -> URL {
        // Generate an URL based on the current parameters and return it
        let url = NewsAPIURLConstant.newsAPIHeadlines.appending("apiKey=\(apiKey)&language=\(language.rawValue)&category=\(category.rawValue)")
        return URL(string: url)!
    }
    
    private func generateSearchNewsURL(from query: String, from previousDate: Date, from currentDate: Date, from sorting: Sorting) -> URL {
        let url = NewsAPIURLConstant.newsAPIEverything
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        // The Date needs to be formatted into an iso8601 otherwise, an error for unwrapping an Optional will be raised
        let currentURL = url.appending("apiKey=\(apiKey)&q=\(encodedQuery)&from=\(previousDate.formatted(.iso8601))&to=\(currentDate.formatted(.iso8601))&sortBy=\(sorting.rawValue)")
        return URL(string: currentURL)!
    }
    
    private func generateSourcesNewsURL(from query: String) -> URL {
        let url = NewsAPIURLConstant.newsAPIHeadlines
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let currentURL = url.appending("sources=\(encodedQuery)&apiKey=\(apiKey)")
        return URL(string: currentURL)!
    }
    
    private func fetchArticles(from url: URL) async throws -> [Article] {
        // Define the data and a response related to the ongoing data
        let (data, response) = try await session.data(from: url)
        
        // Check if the response is returned with HTTP service code like 2xx or raise an error if not
        guard let response = response as? HTTPURLResponse else {
            throw NSError(domain: "NewsAPI", code: 1, userInfo: [NSLocalizedDescriptionKey: "Bad Response"])
        }
        
        // Based on the HTTP Service Code
        switch response.statusCode {
                // If the statusCode return a 2xx code
            case (200...299):
                
                // The data receive are to be decoded on a JSON Format according to the model provided
                let apiResponse = try decoder.decode(APIResponse.self, from: data)
                
                // If the statusCode 2xx is a match for "ok"
                if apiResponse.status == "ok" {
                    return apiResponse.articles
                } else {
                    throw NSError(domain: "NewsAPI", code: 2, userInfo: [NSLocalizedDescriptionKey: "Query Interrupted"])
                }
            default:
                throw NSError(domain: "NewsAPI", code: 3, userInfo: [NSLocalizedDescriptionKey: "A 5xx Error Server has occured ..."])
        }
    }
    
    func fetch(from category: Category, from language: Language) async throws -> [Article] {
        try await fetchArticles(from: generateNewsURL(from: category, from: language))
    }
    
    func fetchSearch(from query: String, from previousDate: Date, from currentDate: Date, from sorting: Sorting) async throws -> [Article] {
        try await fetchArticles(from: generateSearchNewsURL(from: query, from: previousDate, from: currentDate, from: sorting))
    }
    
    func fetchChoiceSearchIn(from query: String) async throws -> [Article] {
        try await fetchArticles(from: generateSourcesNewsURL(from: query))
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
