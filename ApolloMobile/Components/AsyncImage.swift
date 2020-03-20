//
//  AsyncImage.swift
//  ApolloMobile
//
//  Created by s-huang on 2020/03/15.
//  Copyright © 2020 Neo. All rights reserved.
//

import SwiftUI
import Combine



struct AsyncImage: View {
    @ObservedObject private var imageLoader: ImageLoader

    private let placeholder: UIImage

    init(url: String?, placeholder: UIImage? = nil, imageLoader: ImageLoader = ImageLoader()) {
        self.imageLoader = imageLoader
        if let placeholder = placeholder {
            self.placeholder = placeholder
        } else {
            self.placeholder = UIImage(imageLiteralResourceName: "placeholder")
        }
        if let url = url {
            imageLoader.loadImage(url: url)
        }
    }

    var body: some View {
        if let image = imageLoader.image {
            return Image(uiImage: image)
                    .resizable(resizingMode: .stretch)
        } else {
            return Image(uiImage: placeholder)
                    .resizable(resizingMode: .stretch)
        }
    }
}
