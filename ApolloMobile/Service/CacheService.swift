//
//  CacheService.swift
//  ApolloMobile
//
//  Created by s-huang on 2020/03/18.
//  Copyright © 2020 Neo. All rights reserved.
//

import UIKit

class InMemoryImageCacheService {
    static let shared: InMemoryImageCacheService = InMemoryImageCacheService()

    private let cacheStorage: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>() // Should be replaced by persistent cache in production

    private init() {}

    func get(key: String) -> UIImage? {
        return cacheStorage.object(forKey: key as NSString)
    }

    func set(image: UIImage, key: String) {
        cacheStorage.setObject(image, forKey: key as NSString)
    }
}
