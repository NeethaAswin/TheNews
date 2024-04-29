//
//  NetworkProvider.swift
//  TheNewsApp
//
//  Created by Neetha on 25/04/2024.
//

import Foundation
public protocol NetworkProvider {
    func load<T: Decodable>(with request: URLRequest) async throws -> T
}

final class NetworkProviderImpl: NetworkProvider {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol) {
        self.session = session
    }

    func load<T: Decodable>(with request: URLRequest) async throws -> T {

        let (data, response) = try await session.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode ?? 0

        if statusCode == 429 {
            throw NetworkingError.tooManyRequests
        }
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkingError.failedToDecode
        }
        return decoded
    }
}
