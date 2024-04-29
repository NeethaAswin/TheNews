//
//  ResponseModelTests.swift
//  TheNewsTests
//
//  Created by Neetha on 19/04/2024.
//

import XCTest
@testable import TheNewsApp

final class ResponseModelTests: XCTestCase {

    func testEmptyThumbnail() throws {
        let article = Article(source: Source(id: nil, name: "source"),
                              author: "author",
                              title: "title",
                              description: "description",
                              url: "url",
                              urlToImage: nil,
                              publishedAt: "publishedAt",
                              content: "content")
        let response = ResponseModel(status: "status",
                                     totalResults: 10,
                                     articles: [article])

        XCTAssertNil(response.articles.first?.imageURL)
    }
    
    func testThumbnail() {
        let urlString = "www.google.com"
        let article = Article(source: Source(id: nil, name: "source"),
                              author: "author",
                              title: "title",
                              description: "description",
                              url: "url",
                              urlToImage: urlString,
                              publishedAt: "publishedAt",
                              content: "content")
        let response = ResponseModel(status: "status",
                                     totalResults: 10,
                                     articles: [article])
        
        XCTAssertEqual(URL(string: urlString), response.articles.first?.imageURL)
    }

    func testPublishedDate() {
        let date = "2024-04-24T10:20:15Z"
        let formattedString = date.dateFromString()
        let article = Article(source: Source(id: nil, name: "source"),
                              author: "author",
                              title: "title",
                              description: "description",
                              url: "url",
                              urlToImage: "urlToImage",
                              publishedAt: date,
                              content: "content")
        let response = ResponseModel(status: "status",
                                     totalResults: 10,
                                     articles: [article])
        
        XCTAssertEqual(formattedString, response.articles.first?.publishedDate)
    }

    func testNilPublishedDate() {
        let article = Article(source: Source(id: nil, name: "source"),
                              author: "author",
                              title: "title",
                              description: "description",
                              url: "url",
                              urlToImage: "urlToImage",
                              publishedAt: "",
                              content: "content")
        let response = ResponseModel(status: "status",
                                     totalResults: 10,
                                     articles: [article])
        XCTAssertNotNil(response.articles.first?.publishedDate)
    }
}
