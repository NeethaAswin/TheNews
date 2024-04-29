//
//  MockArticleAPI.swift
//  TheNewsTests
//
//  Created by Neetha on 22/04/2024.
//

import Foundation
@testable import TheNewsApp

public final class MockArticleAPI: ArticleAPI {
    public init() {}
    public var stubArticleResponse: Result<[Article], Error>?
    public var didFetchArticles: (() -> Void)?
    public var fetchArticleCallCount = 0

    public func fetchArticle(request: URLRequest) async throws -> [Article] {
        defer { didFetchArticles?() }
        fetchArticleCallCount += 1
        return try stubArticleResponse!.get()
    }

}
