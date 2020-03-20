//
//  NetworkService.swift
//  ApolloMobile
//
//  Created by s-huang on 2020/03/18.
//  Copyright © 2020 Neo. All rights reserved.
//

import Foundation
import Apollo

class NetworkService {
    static let shared: NetworkService = NetworkService()

    private(set) var apolloClient: ApolloClient

    init() {
        apolloClient = ApolloClient(url: URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/")!)
    }
}
