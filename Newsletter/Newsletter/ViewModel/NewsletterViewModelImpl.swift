//
//  NewsletterViewModel.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 23/11/2021.
//

import Foundation

protocol NewsletterViewModel: ObservableObject {
    func fetchAllNews(_ query: String) async
    func fetchHeadlineNews(_ category: String) async
}

@MainActor
final class NewsletterViewModelImpl: NewsletterViewModel {

    @Published private(set) var articles: [Article] = []

    private let service: NewsletterService
    
    init(service: NewsletterService) {
        self.service = service
    }

    // MARK: - General News Function
    func fetchAllNews(_ query: String) async {
        do {
            self.articles = try await service.fetchAllNews(query)
        } catch DecodingError.keyNotFound(let key, let context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
    }


    // MARK: - Headline News Function
    func fetchHeadlineNews(_ category: String) async {
        do {
            self.articles = try await service.fetchHeadlineNews(category)
        } catch DecodingError.keyNotFound(let key, let context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
        }
    }

}
