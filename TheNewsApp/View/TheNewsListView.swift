//
//  TheNewsListView.swift
//  TheNewsApp
//
//  Created by Neetha on 25/04/2024.
//

import Foundation

import SwiftUI

struct TheNewsListView: View {
    @StateObject var viewModel: TheNewsListViewModel = TheNewsListViewModel(
        repository: ArticleRepositoryImpl(
            api: ArticleAPIImpl(
                provider: NetworkProviderImpl(
                    session: URLSession(
                        configuration: .ephemeral)))))
    
    var body: some View {
        ZStack {
            if viewModel.state.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.state.article) { article in
                        TheNewsListItemView(article: article)
                            .background {
                                NavigationLink(destination: TheNewsDetailView(article: article), label: {})
                                    .opacity(0)
                            }
                            .padding()
                            .task {
                                if viewModel.state.article.last == article {
                                    await viewModel.loadNews()
                                }
                            }
                    }
                }
                .refreshable {
                    await viewModel.loadNews()
                }
            }
        }
        .navigationTitle("The News")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Article.self) { article in
            TheNewsDetailView(article: article)
        }
        .task {
            await viewModel.loadNews()
        }
        .alert(isPresented: $viewModel.hasError,
               error: viewModel.error) { }
            .embedInNavigation()
    }
}

#Preview {
    TheNewsListView(viewModel: TheNewsListViewModel(repository: ArticleRepositoryImpl(api: ArticleAPIImpl(provider: NetworkProviderImpl(session: URLSession(configuration: .ephemeral))))))
}

extension View {
    @ViewBuilder
    func embedInNavigation() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                self
            }
        } else {
            NavigationView {
                self
            }
        }
    }
}

