//
//  NetworkingError.swift
//  TheNews
//
//  Created by Neetha on 19/04/2024.
//

import Foundation

enum NetworkingError: LocalizedError {
    case custom(error: Error)
    case failedToDecode
    case invalidURL
    case invalidStatusCode(statusCode: Int)
    case invalidData
    case tooManyRequests
}

extension NetworkingError {
    var errorDescription: String? {
        switch self {
        case .custom(let err):
            return "Something went wrong \(err.localizedDescription)"
        case .failedToDecode:
            return "Failed to decode"
        case .invalidURL:
            return "URL isn't valid"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .tooManyRequests:
            return "Too many requests"
        }
    }
}

extension NetworkingError: Equatable {
    
    static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch(lhs, rhs) {
        case (.custom(let lhsType), .custom(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.failedToDecode, .failedToDecode):
            return true
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case (.invalidData, .invalidData):
            return true
        default:
            return false
        }
    }
}
