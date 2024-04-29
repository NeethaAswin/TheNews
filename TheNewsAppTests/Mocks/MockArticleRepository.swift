//
//  MockArticleRepository.swift
//  TheNewsTests
//
//  Created by Neetha on 22/04/2024.
//

import Foundation

@testable import TheNewsApp

public final class MockArticleRepository: ArticleRepository {
    public init() {}
    public var stubLoadArticlesResponse: Result<[Article], Error>?
    public var didLoadArticles: (() -> Void)?
    public var loadArticlesCallCount = 0
    public func loadArticles() async throws -> [Article] {
        defer { didLoadArticles?() }
        loadArticlesCallCount += 1
        return try stubLoadArticlesResponse!.get()
    }
}
