//
//  URLSessionProtocol.swift
//  TheNews
//
//  Created by Neetha on 22/04/2024.
//

import Foundation

public protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
