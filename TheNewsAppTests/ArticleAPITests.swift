//
//  ArticleAPITests.swift
//  TheNewsTests
//
//  Created by Neetha on 22/04/2024.
//

import XCTest

@testable import TheNewsApp

private enum TestAPIError: Error, Equatable {
    case failed
}

final class ArticleAPITests: XCTestCase {
    var articleApi: ArticleAPI!
    var mockProvider: MockNetworkProvider!

    override func setUp() {
        super.setUp()
        mockProvider = MockNetworkProvider()
        articleApi = ArticleAPIImpl(provider: mockProvider)
    }

    override func tearDown() {
        articleApi = nil
        mockProvider = nil
        super.tearDown()
    }

    func testFetchArticleOnSuccess() async {
        guard let path = Bundle.main.path(forResource: "Sample", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        let expectedArticles = try? JSONDecoder().decode(ResponseModel.self, from: data).articles
        mockProvider.stubDataResponse = .success(data)

        let resultArticle = try? await articleApi.fetchArticle(request: URLRequest(url: URL(string: "Sample")!))
        XCTAssertEqual(resultArticle?.count, expectedArticles?.count)
    }
    
    func testFetchArticlesSuccessOnEmptyArray() async {
        let expectedEmptyArray = [Article]()
        let emptyData = try? JSONEncoder().encode(expectedEmptyArray)
        mockProvider.stubDataResponse = .success(emptyData ?? Data())
        let request = URLRequest(url: URL(string: "Sample")!)
        let resultArticle = try? await articleApi.fetchArticle(request: request)
        XCTAssertNil(resultArticle)
    }

    func testFetchArticleOnFailure() async {
        mockProvider.stubDataResponse = .failure(TestAPIError.failed)

        do {
            _ = try await articleApi.fetchArticle(request: URLRequest(url: URL(string: "Sample")!))
            XCTFail("Expected to fail")
        } catch {
            XCTAssertEqual(error as? TestAPIError, .failed)
        }
    }
}
