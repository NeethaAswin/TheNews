//
//  MockURLSession.swift
//  TheNewsTests
//
//  Created by Neetha on 22/04/2024.
//

import Foundation

@testable import TheNewsApp
public final class MockURLSession: URLSessionProtocol {
    
    public init() {}
    public var stubDataResponse: Result<(Data, URLResponse), Error>?
    public private (set) var capturedURL: URL?
    
    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        capturedURL = request.url
        return try stubDataResponse!.get()
    }
}
