//
//  NewsletterViewModel.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 23/11/2021.
//

import Foundation

@MainActor
class NewsletterViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    
    init() {
        Task(priority: .medium) {
            await loadData(with: urlString)
        }
    }
    
    @Published var urlString = "https://newsapi.org/v2/everything?apiKey=API_KEY_HERE"
    @Published var urlStringHeadLines = "https://newsapi.org/v2/top-headlines?country=us&apiKey=API_KEY_HERE"
    
    // MARK: - General News Function
    func loadData(with urlString: String) async {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(NewsletterModel.self, from: data) {
                articles = decodedResponse.articles
                print("[✅] Data Fetched! [✅]")
            }
        } catch {
            print("Invalid Data")
        }
    }
    
    
    // MARK: - Headline News Function
    func loadHeadlineData(with urlString: String) async {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(NewsletterModel.self, from: data) {
                articles = decodedResponse.articles
                print("[✅] Data Fetched! [✅]")
            }
        } catch {
            print("Invalid Data")
        }
    }
    
}
