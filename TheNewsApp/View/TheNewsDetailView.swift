//
//  TheNewsDetailView.swift
//  TheNewsApp
//
//  Created by Neetha on 25/04/2024.
//

import SwiftUI

struct TheNewsDetailView: View {
    let article: Article
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let url = article.imageURL {
                    ImageLoadableView(imageUrl: url)
                } else {
                    ProgressView()
                }
                Text(article.source.name)
                    .font(.headline)
                Text(article.title)
                    .font(.subheadline)
                Text(article.content)
                    .font(.system(size: 10, weight: .light))
            }.padding()
        }
    }
}

#Preview {
    TheNewsDetailView(article: Article(source: Source(id: nil, name: "source"),
                                       author: "author",
                                       title: "title",
                                       description: "description",
                                       url: "url",
                                       urlToImage: "urltoImage",
                                       publishedAt: "publishedAt",
                                       content: "content"))
}
