//
//  LaunchList.swift
//  ApolloMobile
//
//  Created by s-huang on 2020/03/16.
//  Copyright © 2020 Neo. All rights reserved.
//

import SwiftUI
import Combine

typealias Launch = GetLaunchesQuery.Data.Launch.Launch

struct LaunchList: View {

    @ObservedObject var controller: LaunchListController = LaunchListController()
    @State var selection: Launch?
    @State var isLoginPresented: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                List(controller.launches) { launch in
                    NavigationLink(destination: LaunchDetail(launch: launch)) {
                        LaunchListCell(launch: launch).onAppear {
                            self.controller.itemDidAppear(launch: launch)
                        }
                    }
                }
                .navigationBarTitle("The Apollo Projects")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.isLoginPresented.toggle()
                    }) {
                        Text("Login")
                    }
                ).sheet(isPresented: $isLoginPresented) {
                    LoginView(isPresented: self.$isLoginPresented)
                }
                LoadingView(isLoading: $controller.isLoading)
            }
        }
    }
}

struct LaunchListCell: View {
    fileprivate let launch: Launch
    var body: some View {
        let title = launch.mission?.name ?? "Unknow mission"
        let subtitle = launch.rocket?.name ?? "Unknown rocket"
        let imageUrl = launch.mission?.missionPatch
        return HStack {
            AsyncImage(url: imageUrl)
                .frame(width: 45, height: 45)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 17))
                Text(subtitle)
                    .font(.system(size: 9))
            }
        }
    }
}

struct LaunchList_Previews: PreviewProvider {
    static var previews: some View {
        LaunchList()
    }
}


