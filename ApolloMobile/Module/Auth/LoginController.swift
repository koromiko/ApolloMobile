//
//  LoginController.swift
//  ApolloMobile
//
//  Created by Neo on 2020/3/21.
//  Copyright © 2020 Neo. All rights reserved.
//

import Combine
import Apollo

enum AuthInputError {
    case emailNotValid
    case inputIsEmpty
    case serverResponseError
    case networkError
}

class LoginController: ObservableObject {
    private let apolloClient: ApolloClient = NetworkService.shared.apolloClient

    @Published var token: String?
    @Published var error: AuthInputError?
    @Published var email: String = ""
    @Published var inputError: AuthInputError?

    func login() {
        if let error = validateEmail(email: email) {
            inputError = error
            return
        }

        apolloClient.perform(mutation: LoginMutation(email: email)) { (result) in
            switch result {
            case .success(let queryResponse):
                if let token = queryResponse.data?.login {
                    self.token = token
                } else {
                    self.error = .serverResponseError
                }
            case .failure(_):
                self.error = .networkError
            }
        }
    }

    func validateEmail(email: String?) -> AuthInputError? {
        if let email = email, !email.isEmpty {
            if email.contains("@") { // naive
                return .emailNotValid
            } else {
                return nil
            }
        } else {
            return .inputIsEmpty
        }
    }
}
