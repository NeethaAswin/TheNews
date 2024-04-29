//
//  ImageLoader.swift
//  TheNewsApp
//
//  Created by Neetha on 25/04/2024.
//

import Foundation
import UIKit

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published private(set) var error: NetworkingError?
    
    @MainActor
    func loadImage(from url: URL) async {
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            image = UIImage(data: data)
        } catch {
            print(error)
        }
    }
}
