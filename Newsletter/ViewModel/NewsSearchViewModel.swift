//
//  NewsSearchViewModel.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 04/06/2023.
//

import SwiftUI

@MainActor
final class NewsSearchViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var searchText: String = ""
    @Published var sortingParam: Sorting = .publishedAt
    @Published var articleFromPreviousDate: Date = .now
    @Published var articleToNextDate: Date = .now
    
    @Published var searchIn: Choice = .names
    @Published var entries = [String]()
    
    static let shared = NewsSearchViewModel()
    
    private let entriesDataStore = PlistDataStore<[String]>(filename: "entries")
    private let entriesMaxLimit = 10
    
    private let newsAPI = NewsAPI.shared
    
    // Apply a limit until when users can get articles from the API - The Articles are stored by the API for only a month
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let fromPreviousMonth = calendar.date(byAdding: .month, value: -1, to: Date.now)
        let startComponents =  calendar.dateComponents([.year, .month, .day], from: fromPreviousMonth!)
        let endComponents = calendar.dateComponents([.year, .month, .day], from: Date.now)
        return calendar.date(from: startComponents)!
        ...
        calendar.date(from: endComponents)!
    }()
    
    private init(articles: [Article]? = nil, searchText: String = "", sortingParam: Sorting = .publishedAt, articleFromPreviousDate: Date = .now, articleToNextDate: Date = .now, searchIn: Choice = .names) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        load()
    }
    
    func addEntry(_ text: String) {
        if let index = entries.firstIndex(where: { text.lowercased() == $0.lowercased() }) {
            entries.remove(at: index) // To avoid getting 2x to 3x times or more the same entry in the list
        } else if entries.count == entriesMaxLimit {
            entries.remove(at: entries.count - 1) // Replace the last entry with the newest one, if the limit of 10 is reached
        }
        
        entries.insert(text, at: 0)
        entriesUpdated()
    }
    
    func removeEntry(_ text: String) {
        // Get the index
        guard let index = entries.firstIndex(where: { text.lowercased() == $0.lowercased() }) else {
            return
        }

        entries.remove(at: index)
        entriesUpdated()
    }
    
    func removeAllEntries() {
        // Remove all entries saved but keep the capacity allocated to store or replace if the limit of 10 is reached
        entries.removeAll(keepingCapacity: true)
        entriesUpdated()
    }
    
    func loadSearchedArticles() async {
        if Task.isCancelled { return } // Don't Initialize a Task unless a search is requested by the user
        phase = .empty
        
        // Trim the Spaces and New Lines of the search field
        let searchQuery = self.searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        // Replace all white spaces with a "+" for the search, i.e: San+Francisco rather than San Francisco
        let queryName = searchQuery.replacingOccurrences(of: " ", with: "+")
        
        if queryName.isEmpty { return }
        
        // Allow the users to switch between two kinds of search: by Proper Name or by Journalistic Sources
        if searchIn == .names {
            do {
                let articles = try await newsAPI.fetchSearch(from: queryName, from: articleFromPreviousDate, from: articleToNextDate, from: sortingParam)
                if Task.isCancelled { return }
                phase = .success(articles)
            } catch {
                if Task.isCancelled { return }
                print(error.localizedDescription)
                phase = .failure(error)
            }
        } else {
            do {
                let articles = try await newsAPI.fetchChoiceSearchIn(from: queryName)
                if Task.isCancelled { return } // Stop the Task after getting the articles
                phase = .success(articles)
            } catch {
                if Task.isCancelled { return } // Stop the Task if an error is raised
                print(error.localizedDescription)
                phase = .failure(error)
            }
        }
    }
    
    private func load() {
        Task {
            self.entries = await entriesDataStore.load() ?? []
        }
    }
    
    private func entriesUpdated() {
        let entries = self.entries
        Task {
            await entriesDataStore.save(entries)
        }
    }
    
    var articles: [Article] {
        // If current phase status is a match from the articles request
        if case let .success(articles) = phase {
            return articles
        } else {
            return []
        }
    }
    
}
