//
//  AppDelegate.swift
//  GitDemo
//
//  Created by echo on 2025/5/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        setupNavigationBarAppearance()
        setupLanguage()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white // Set a default background color
        let splashVC = SplashViewController()
        window?.rootViewController = splashVC // Set SplashViewController as the root view controller
        window?.makeKeyAndVisible()
        return true
    }

    private func setupNavigationBarAppearance() {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white // Set the navigation bar background color
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black] // Set title color
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black] // Set large title color (if used)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = .white // iOS 12 and earlier
            UINavigationBar.appearance().tintColor = .black // Set button color
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
        UINavigationBar.appearance().isTranslucent = false // Usually set to false
    }

    private func setupLanguage() {
        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }

}
