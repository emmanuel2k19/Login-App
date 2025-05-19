//
//  RegisterViewController.swift
//  Login
//
//  Created by Emmanuel Pena on 5/15/25.
//
import UIKit

class RegisterViewController: UIViewController {
    
    let nameField = UITextField()
    let passwordField = UITextField()
    let createButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        nameField.placeholder = "Name"
        nameField.autocapitalizationType = .none
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        createButton.setTitle("Create Account", for: .normal)
        createButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [nameField,passwordField, createButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func createAccountTapped() {
        guard let name = nameField.text?.lowercased(),
              let password = passwordField.text else { return }

        print("🔘 Button tapped, sending name: \(name), password: \(password)")

        let url = URL(string: "http://192.168.0.43:3000/api/register")! // adjust if your backend route is different
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["username": name,"password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("📡 Response code:", httpResponse.statusCode)

                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        print("📦 Raw response:", json)

                        DispatchQueue.main.async {
                            if httpResponse.statusCode == 201 {
                                self.showAlert(title: "Success", message: "User registered successfully")
                            } else {
                                let errorMessage = json["error"] as? String ?? "Something went wrong."
                                self.showAlert(title: "Error", message: errorMessage)
                            }
                        }
                    }
                }
            } else if let error = error {
                print("❌ Network error:", error.localizedDescription)
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
}
