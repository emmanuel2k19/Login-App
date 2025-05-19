//
//  ViewController.swift
//  Login
//
//  Created by Emmanuel Pena on 5/9/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func loadView() {
            view = loginView
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginView.createAccountButton.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
    }
    
    
     
        @objc func handleLogin() {
            let email = loginView.emailTextField.text ?? ""
            let password = loginView.passwordTextField.text ?? ""
        
        if email.isEmpty || password.isEmpty {
            showAlert(message: "Please enter both email and password.")
            return
        }
        
        if email == "user@example.com" && password == "123456" {
            showAlert(message: "Login successful!")
        } else {
            showAlert(message: "Invalid credentials.")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        }
    
    @objc func goToRegister() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
}

