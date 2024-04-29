//
//  TheNewsAPI.swift
//  TheNewsApp
//
//  Created by Neetha on 09/11/2023.
//

import Foundation
import UIKit

protocol ArticleRepository {
    func loadArticles() async throws -> [Article]
}

public final class ArticleRepositoryImpl: ArticleRepository {

    let api: ArticleAPI
    init(api: ArticleAPI) {
        self.api = api
    }

    func loadArticles() async throws -> [Article] {
        let request = ArticleRepositoryImpl.createRequest()
        return try await api.fetchArticle(request: request)
    }

    private static func createRequest() -> URLRequest {
        let baseURL = URL(string: "https://newsapi.org/v2/everything")!
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            .init(name: "q", value: "tesla"),
            .init(name: "apiKey", value: Configuration().apiKey),
            .init(name: "from", value: "2024-04-01"),
            .init(name: "sortBy", value: "publishedAt")]
        return URLRequest(url: components.url!)
    }
}
