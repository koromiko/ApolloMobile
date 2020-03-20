//
//  AsyncImageLoader.swift
//  ApolloMobile
//
//  Created by s-huang on 2020/03/15.
//  Copyright © 2020 Neo. All rights reserved.
//

import UIKit
import Combine

class ImageLoader: ObservableObject {

    @Published var image: UIImage?

    private let cacheService = InMemoryImageCacheService.shared
    private let networkService = URLSession.shared

    func loadImage(url: String) {
        if let cachedImage = cacheService.get(key: url) {
            self.image = cachedImage
        } else {
            networkService.dataTask(with: URL(string: url)!) { [weak self] (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    if let image = image {
                        self?.cacheService.set(image: image, key: url)
                    }
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: data)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.image = nil
                    }
                    if let error = error {
                        print("Load image error \(error.localizedDescription)")
                    } else {
                        print("Load image with unknown error")
                    }
                }
            }.resume()
        }
    }

}


