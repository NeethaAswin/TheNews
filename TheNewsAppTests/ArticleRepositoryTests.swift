//
//  NetworkManagerTests.swift
//  TheNewsTests
//
//  Created by Neetha on 21/04/2024.
//

import Foundation

@testable import TheNewsApp
import XCTest

class ArticleRepositoryTests: XCTestCase {
    var api: MockArticleAPI!
    var repository: ArticleRepository!
    
    override func setUp() {
        api = MockArticleAPI()
        repository = ArticleRepositoryImpl(api: api)
        super.setUp()
    }

    override func tearDown() {
        repository = nil
        api = nil
        super.tearDown()
    }

    func testLoadArticleCallsAPIOnSuccess() async throws {
        api.stubArticleResponse = .success([])
        _ = try await repository.loadArticles()
        XCTAssertEqual(api.fetchArticleCallCount, 1)
    }
    
    func testLoadArticleCallsAPIOnFailure() async throws {
        api.stubArticleResponse = .failure(NetworkingError.invalidURL)
        do {
            _ = try await repository.loadArticles()
            XCTFail("Expected to fail")
        } catch {
            XCTAssertEqual(error as? NetworkingError, .invalidURL)
        }
    }
}
