//
//  LoginView.swift
//  ApolloMobile
//
//  Created by Neo on 2020/3/21.
//  Copyright © 2020 Neo. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var controller: LoginController = LoginController()
    @Binding var isPresented: Bool
    @State var isAuthSuccess: Bool = false
    @State var email: String?

    var body: some View {
        VStack {
            InputField(email: $controller.email)
            Button(action: {
                self.controller.login()
            }) {
                Text("Submit")
            }
        }.frame(width: 200)
    }

    func login() {
        if let email = email, !email.isEmpty {
            NetworkService.shared.apolloClient.perform(mutation: LoginMutation(email: email)) { (result) in
                if let token = try? result.get().data?.login {
                    print("Token \(token)")
                }
            }
        }
    }
}

private struct InputField: View {
    @Binding var email: String
    var body: some View {
        HStack {
            Text("Email")
            TextField("Please input email", text: $email)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isPresented: .constant(true))
    }
}
