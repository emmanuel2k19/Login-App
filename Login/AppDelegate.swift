//
//  AppDelegate.swift
//  Login
//
//  Created by Emmanuel Pena on 5/9/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController() // Replace with your root VC
        window?.makeKeyAndVisible()

        return true
    }
}
