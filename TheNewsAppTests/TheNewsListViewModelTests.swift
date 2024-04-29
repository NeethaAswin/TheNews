//
//  TheNewsListViewModelTests.swift
//  TheNewsTests
//
//  Created by Neetha on 19/04/2024.
//

import XCTest
@testable import TheNewsApp

final class TheNewsListViewModelTests: XCTestCase {
    var viewModel: TheNewsListViewModel!
    var repository: MockArticleRepository!

    enum MockError: Error {
        case test
    }
    
    override func setUp() {
        super.setUp()
        repository = MockArticleRepository()
        viewModel = TheNewsListViewModel(repository: repository)
    }

    override func tearDown() {
        repository = nil
        viewModel = nil
        super.tearDown()
    }

    func testLoadArticlesSuccessOnRepository() async {
        repository.stubLoadArticlesResponse = .success(
            [Article(source: Source(id: nil, name: "source"),
                     author: "author",
                     title: "title",
                     description: "description",
                     url: "url",
                     urlToImage: "urltoImage",
                     publishedAt: "publishedAt",
                     content: "content")]
        )
        await viewModel.loadNews()
        XCTAssertEqual(viewModel.state.article.count, 1)
        XCTAssertEqual(viewModel.hasError, false)
        XCTAssertEqual(repository.loadArticlesCallCount, 1)
    }

    func testLoadArticlesFailedOnRepository() async {
        repository.stubLoadArticlesResponse = .failure(MockError.test)
        await viewModel.loadNews()
        XCTAssertEqual(viewModel.state.article.count, 0)
        XCTAssertEqual(viewModel.state.isLoading, false)
        XCTAssertEqual(viewModel.hasError, true)
        XCTAssertEqual(repository.loadArticlesCallCount, 1)
    }

    func testLoadArticlesFailedOnRepository_InvalidUrl() async {
        repository.stubLoadArticlesResponse = .failure(NetworkingError.invalidURL)
        await viewModel.loadNews()
        XCTAssertEqual(viewModel.state.article.count, 0)
        XCTAssertEqual(viewModel.state.isLoading, false)
        XCTAssertEqual(viewModel.hasError, true)
        XCTAssertEqual(repository.loadArticlesCallCount, 1)
    }
}

extension Article {
    static func mock(id: Int = 0) -> Article {
        return Article(source: Source(id: nil, name: "source"),
                       author: "author",
                       title: "title",
                       description: "description",
                       url: "url",
                       urlToImage: "urltoImage",
                       publishedAt: "publishedAt",
                       content: "content")
    }

    static func mockEmptyImage(id: Int = 0) -> Article {
        return Article(source: Source(id: nil, name: "source"),
                       author: "author",
                       title: "title",
                       description: "description",
                       url: "url",
                       urlToImage: nil,
                       publishedAt: "publishedAt",
                       content: "content")
    }

    static func mockLoadableImage(id: Int = 0) -> Article {
        return Article(source: Source(id: nil, name: "source"),
                       author: "author",
                       title: "title",
                       description: "description",
                       url: "url",
                       urlToImage: "www.google.com",
                       publishedAt: "publishedAt",
                       content: "content")
    }
    
    static var mockArticles: [Article] {
        (0..<5).map(Article.mock)
    }
}
