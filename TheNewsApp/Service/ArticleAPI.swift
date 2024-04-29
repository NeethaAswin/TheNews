//
//  NetworkManager.swift
//  TheNews
//
//  Created by Neetha on 19/04/2024.
//

import Foundation

protocol ArticleAPI {
    func fetchArticle(request: URLRequest) async throws -> [Article]
}

public final class ArticleAPIImpl: ArticleAPI {
    @Published var articles = [Article]()
    private let provider: NetworkProvider

    init(provider: NetworkProvider) {
        self.provider = provider
    }

    func fetchArticle(request: URLRequest) async throws -> [Article] {
        var fetchedResponse: ResponseModel
        fetchedResponse = try await provider.load(with: request)
        return fetchedResponse.articles
    }
}
