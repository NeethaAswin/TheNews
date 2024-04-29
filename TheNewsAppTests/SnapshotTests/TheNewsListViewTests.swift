//
//  TheNewsListViewTests.swift
//  TheNewsTests
//
//  Created by Neetha on 23/04/2024.
//

import XCTest
import SnapshotTesting
import SwiftUI

@testable import TheNewsApp

final class TheNewsListViewTests: XCTestCase {

    var contentView: TheNewsListView!

    override func tearDown() {
        contentView = nil
        super.tearDown()
    }

    func testEmptyContentView() {
        let contentView = TheNewsListView()
        assertSnapshot(matching: contentView.toVC(), as: .image(on: .iPhoneX))
    }
    
    func testInitial() {
        let viewModel = TestViewModel()
        contentView = TheNewsListView(viewModel: viewModel)
        
        let state = TheNewsListViewModel.State(article: [],
                                               isLoading: false)
        viewModel.set(state: state)
        assertSnapshot(matching: contentView.toVC(), as: .image(on: .iPhoneX))
    }
    
    func testLoadingDetails() {
        let viewModel = TestViewModel()
        contentView = TheNewsListView(viewModel: viewModel)

        let state = TheNewsListViewModel.State(article: Article.mockArticles,
                                               isLoading: true)
        viewModel.set(state: state)
        assertSnapshot(matching: contentView.toVC(), as: .image(on: .iPhoneX))
    }
}

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}

final class TheNewsListItemViewTests: XCTestCase {
    func testView() {
        let contentView = TheNewsListItemView(article: .mock())
        assertSnapshot(matching: contentView.toVC(), as: .image(on: .iPhoneX))
    }
}
