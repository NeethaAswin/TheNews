//
//  TheNewsListViewModel.swift
//  TheNewsApp
//
//  Created by Neetha on 25/04/2024.
//

import Foundation

class TheNewsListViewModel: ObservableObject {

    @Published private(set) var error: NetworkingError?
    @Published var hasError = false

    private let repository: ArticleRepository
    
    init(repository: ArticleRepository) {
        self.repository = repository
    }

    @Published fileprivate (set) var state = State()

    @MainActor
    func loadNews() async {
        state.isLoading = true
        defer { state.isLoading = false }
        do {
            state.article = try await repository.loadArticles()
        } catch {
            hasError = true
            if let networkingError = error as? NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }

    struct State {
        var article: [Article] = []
        var isLoading: Bool = false
    }
}


class TestViewModel: TheNewsListViewModel {
    func set(state: State) {
        self.state = state
    }
    init() {
        super.init(repository: ArticleRepositoryImpl(
            api: ArticleAPIImpl(
                provider: NetworkProviderImpl(
                        session: URLSession(
                                configuration: .ephemeral)))))
    }
}
