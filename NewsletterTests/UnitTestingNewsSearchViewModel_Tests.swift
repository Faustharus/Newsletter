//
//  UnitTestingNewsSearchViewModel_Tests.swift
//  NewsletterTests
//
//  Created by Damien Chailloleau on 11/06/2023.
//

import XCTest
@testable import Newsletter

final class UnitTestingNewsSearchViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor func test_NewsSearchViewModel_articles_shouldBeEmpty() async {
        let vm = NewsSearchViewModel.shared
        let shared = NewsAPI.shared
        
        do {
            let _ = try await shared.fetchSearch(from: "", from: Date.now, from: Date.now, from: .publishedAt)
            vm.phase = .empty
        } catch {
            print(error.localizedDescription)
        }
        
        XCTAssertTrue(vm.articles.isEmpty)
        XCTAssertEqual(vm.articles.count, 0)
    }
    
    @MainActor func test_NewsSearchViewModel_articles_shouldNotBeEmpty() async {
        let vm = NewsSearchViewModel.shared
        let shared = NewsAPI.shared
        let timeInterval = vm.dateRange
        let suggestion = vm.entries.randomElement() ?? "Apple"
        
        do {
            let query = try await shared.fetchSearch(from: suggestion, from: timeInterval.lowerBound, from: .now, from: .publishedAt)
            vm.phase = .success(query)
        } catch {
            print(error.localizedDescription)
        }
        
        XCTAssertTrue(!vm.articles.isEmpty)
        XCTAssertFalse(vm.articles.isEmpty)
        XCTAssertNotEqual(vm.articles.count, 0)
        XCTAssertGreaterThan(vm.articles.count, 0)
    }

}
