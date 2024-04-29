//
//  TheNewsListItemView.swift
//  TheNewsApp
//
//  Created by Neetha on 25/04/2024.
//

import SwiftUI

struct TheNewsListItemView: View {
    var article: Article
    var body: some View {
        HStack {
            if let url = article.imageURL {
                ImageLoadableView(imageUrl: url)
            } else {
                ProgressView()
            }
            VStack(spacing: 5) {
                Text(article.title).font(.system(size: 12, weight: .bold))
                Text(article.content).font(.system(size: 10, weight: .light))
            }
        }
    }
}

#Preview {
    TheNewsListItemView(article: Article(source: Source(id: nil, name: "source"),
                                         author: "author",
                                         title: "title",
                                         description: "description",
                                         url: "url",
                                         urlToImage: "urltoImage",
                                         publishedAt: "publishedAt",
                                         content: "content"))
}
