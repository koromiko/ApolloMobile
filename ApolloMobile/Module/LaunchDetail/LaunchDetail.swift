//
//  LaunchDetail.swift
//  ApolloMobile
//
//  Created by s-huang on 2020/03/18.
//  Copyright © 2020 Neo. All rights reserved.
//

import SwiftUI

struct LaunchDetail: View {
    var launch: Launch

    @ObservedObject private var controller: LaunchDetailController

    init(launch: Launch) {
        self.launch = launch
        self.controller = LaunchDetailController(launch: launch)
    }

    var body: some View {
        VStack(spacing: 10) {
            InfoBlock(title: "Mission", detail: controller.launchDetail?.mission?.name ?? "")

            AsyncImage(url: controller.launchDetail?.mission?.missionPatch)
                .frame(width: 350, height: 350, alignment: .center)

            InfoBlock(title: "Rocket", detail: rocketComposer())
            InfoBlock(title: "Site", detail: controller.launchDetail?.site ?? "")
        }
        .navigationBarTitle(launch.mission?.name ?? "")
        .onAppear(perform: controller.loadLaunchDetail)
    }

    private func rocketComposer() -> String {
        return "\(controller.launchDetail?.rocket?.name ?? "") (\(controller.launchDetail?.rocket?.type ?? ""))"
    }
}

private struct InfoBlock: View {
    let title: String
    let detail: String
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(Color.gray)
            Text(detail)
                .font(Font.system(size: 14, weight: .bold))
        }
    }
}

struct LaunchDetail_Previews: PreviewProvider {
    static var stub: [String: Any] {
        let jsonString = """
            {
              "id": "91",
              "rocket": {
                "name": "Falcon 9"
              },
              "mission": {
                "name": "CRS-20",
                "missionPatch": "https://images2.imgbox.com/53/22/dh0XSLXO_o.png"
              }
            }
        """
        return (try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)) as! [String: Any]
    }
    static var previews: some View {
        LaunchDetail(launch: try! Launch(jsonObject: stub))
    }
}
