//
//  UnitTestingNewsArticleViewModel_Tests.swift
//  NewsletterTests
//
//  Created by Damien Chailloleau on 11/06/2023.
//

import XCTest
@testable import Newsletter

final class UnitTestingNewsArticleViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor func test_NewsArticleViewModel_selectedCategory_shouldBeInjectedValue() {
        let shouldBeStartAtDotGeneral = NewsArticleViewModel()
        
        let articleCategory = shouldBeStartAtDotGeneral.selectedCategory
        let selectedCategory = articleCategory.rawValue
        
        XCTAssertEqual(shouldBeStartAtDotGeneral.selectedCategory.rawValue, selectedCategory)
    }
    
    @MainActor func test_NewsArticleViewModel_selectedLanguage_shouldBeInjectedValue() {
        let shouldBeStartAtDotGeneral = NewsArticleViewModel()
        
        let languageCategory = shouldBeStartAtDotGeneral.selectedLanguages
        let selectedCategory = languageCategory.rawValue
        
        XCTAssertEqual(shouldBeStartAtDotGeneral.selectedLanguages.rawValue, selectedCategory)
    }
    
    @MainActor func test_NewsArticleViewModel_articles_shouldBeEmpty() {
        let vm = NewsArticleViewModel()
        
        vm.phase = .empty
        
        XCTAssertTrue(vm.articles.isEmpty)
        XCTAssertEqual(vm.articles.count, 0)
    }
    
    @MainActor func test_NewsArticleViewModel_articles_shouldNotBeEmpty() async {
        let vm = NewsArticleViewModel()
        
        do {
            await vm.loadArticles()
            vm.phase = .success(vm.articles)
        }
        
        XCTAssertTrue(!vm.articles.isEmpty)
        XCTAssertFalse(vm.articles.isEmpty)
        XCTAssertNotEqual(vm.articles.count, 0)
        XCTAssertGreaterThan(vm.articles.count, 0)
    }

}
