//
//  ConfigurationTests.swift
//  TheNewsTests
//
//  Created by Neetha on 21/04/2024.
//

import Foundation

import XCTest

@testable import TheNewsApp

final class ConfigurationTests: XCTestCase {
    
    func testGetApiKeySuccess() {
        let provider: (String) -> Any? = { _ in return "test" }
        let apiKey = getApiKey(from: provider)
        XCTAssertEqual(apiKey, "test")
    }
    
    func testGetApiKeyFailure() {
        let provider: (String) -> Any? = { _ in return nil }
        let apiKey = getApiKey(from: provider)
        XCTAssertTrue(apiKey.isEmpty)
    }
}
