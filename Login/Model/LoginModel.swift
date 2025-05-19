//
//  LoginModel.swift
//  Login
//
//  Created by Emmanuel Pena on 5/12/25.
//
struct User {
    let email: String
    let password: String

    func isValid() -> Bool {
        return email == "user@example.com" && password == "123456"
    }

    var isEmpty: Bool {
        return email.isEmpty || password.isEmpty
    }
}
