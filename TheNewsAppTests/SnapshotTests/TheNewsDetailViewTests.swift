//
//  TheNewsDetailViewTests.swift
//  TheNewsTests
//
//  Created by Neetha on 24/04/2024.
//

import XCTest


import SnapshotTesting
import SwiftUI

@testable import TheNewsApp

final class TheNewsDetailViewTests: XCTestCase {
    func testView() {
        let contentView = TheNewsDetailView(article: .mock())
        assertSnapshot(matching: contentView.toVC(), as: .image(on: .iPhoneX))
    }
    
    func testViewWithNilImage() {
        let contentView = TheNewsDetailView(article: .mockEmptyImage())
        assertSnapshot(matching: contentView.toVC(), as: .image(on: .iPhoneX))
    }

    func testViewWithImage() {
        let contentView = TheNewsDetailView(article: .mockLoadableImage())
        assertSnapshot(matching: contentView.toVC(), as: .image(on: .iPhoneX))
    }
}
