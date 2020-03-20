//
//  LoadingView.swift
//  ApolloMobile
//
//  Created by s-huang on 2020/03/19.
//  Copyright © 2020 Neo. All rights reserved.
//

import SwiftUI
import Combine

struct LoadingView: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    @Binding var isLoading: Bool

    func makeUIView(context: UIViewRepresentableContext<LoadingView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<LoadingView>) {
        isLoading ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(true))
    }
}
