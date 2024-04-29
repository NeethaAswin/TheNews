//
//  MockNetworkProvider.swift
//  TheNewsAppTests
//
//  Created by Neetha on 25/04/2024.
//

import Foundation


@testable import TheNewsApp
public final class MockNetworkProvider: NetworkProvider {
    
    public init() {}

    public var stubDataResponse: Result<Data, Error>?
    public func load<T: Decodable>(with request: URLRequest) async throws -> T where T : Decodable {
        return try JSONDecoder().decode(T.self, from: stubDataResponse!.get())
    }
}
