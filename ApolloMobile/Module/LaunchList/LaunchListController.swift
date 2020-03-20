//
//  LaunchListController.swift
//  ApolloMobile
//
//  Created by s-huang on 2020/03/18.
//  Copyright © 2020 Neo. All rights reserved.
//

import Combine
import Apollo

class LaunchListController: ObservableObject {
    typealias Launch = GetLaunchesQuery.Data.Launch.Launch

    @Published var launches: [Launch] = []
    @Published var error: Error?
    @Published var isLoading: Bool = false

    private var lastConnection: GetLaunchesQuery.Data.Launch?

    private let apolloClient: ApolloClient = NetworkService.shared.apolloClient

    init() {
        loadLaunchList()
    }

    func loadLaunchList() {
        guard self.lastConnection?.hasMore ?? true, !isLoading else { return } // All data are fetched or first fetch }
        isLoading = true
        apolloClient.fetch(query: GetLaunchesQuery(cursor: lastConnection?.cursor, pageSize: 10)) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let queryResult):
                self.isLoading = false
                let launchConnection = queryResult.data?.launches
                let launches = queryResult.data?.launches.launches.compactMap { $0 } ?? []
                self.launches.append(contentsOf: launches)
                self.lastConnection = launchConnection
            case .failure(let error):
                self.isLoading = false
                self.error = error
            }
        }
    }

    func itemDidAppear(launch: Launch) {
        if launch == launches.last {
            loadLaunchList()
        }
    }
}

extension GetLaunchesQuery.Data.Launch.Launch: Identifiable, Hashable {
    public static func == (lhs: GetLaunchesQuery.Data.Launch.Launch, rhs: GetLaunchesQuery.Data.Launch.Launch) -> Bool {
        return lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

