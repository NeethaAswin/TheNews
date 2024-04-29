//
//  ImageLoader.swift
//  TheNewsApp
//
//  Created by Neetha on 26/04/2024.
//

import SwiftUI


struct ImageLoadableView: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageUrl: URL

    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
            } else {
                ProgressView()
            }
        }
        .task {
            await imageLoader.loadImage(from: imageUrl)
        }
    }
}
