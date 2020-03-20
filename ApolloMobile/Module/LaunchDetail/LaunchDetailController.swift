//
//  LaunchDetailController.swift
//  ApolloMobile
//
//  Created by s-huang on 2020/03/18.
//  Copyright © 2020 Neo. All rights reserved.
//

import Combine
import Apollo

class LaunchDetailController: ObservableObject {
    @Published var launchDetail: GetLaunchDetailQuery.Data.Launch?
    @Published var errorMessage: String?

    private var launch: GetLaunchesQuery.Data.Launch.Launch
    private let apolloClient: ApolloClient = NetworkService.shared.apolloClient
    private var watcher: GraphQLQueryWatcher<GetLaunchDetailQuery>?

    init(launch: GetLaunchesQuery.Data.Launch.Launch) {
        self.launch = launch
    }

    deinit {
        watcher?.cancel()
    }

    func loadLaunchDetail() {
        watcher?.cancel()
        watcher = apolloClient.watch(query: GetLaunchDetailQuery(id: launch.id), cachePolicy: .returnCacheDataAndFetch) { [weak self] (result) in
            switch result {
            case .success(let queryResult):
                if let detail = queryResult.data?.launch {
                    self?.launchDetail = detail
                } else {
                    self?.errorMessage = "Something went wrong"
                }
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}
