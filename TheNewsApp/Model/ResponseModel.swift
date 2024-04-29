//
//  ResponseModel.swift
//  TheNewsApp
//
//  Created by Neetha on 08/11/2023.
//

import Foundation

struct ResponseModel: Codable {
    let status: String
    let totalResults: Int
    var articles: [Article]
}

struct Article: Codable, Equatable, Hashable, Identifiable {
    var id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content
    }
}

struct Source: Codable, Hashable {
    let id: String?
    let name: String
}

extension Article {
    var publishedDate: Date? {
        publishedAt.dateFromString()
    }
    var imageURL: URL? {
        URL(string: urlToImage ?? "")
    }
}

extension String {
    func dateFromString() -> Date {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: self) ?? Date.now
        return date
    }
}
