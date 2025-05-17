//
//  AppDelegate.swift
//  GitDemo
//
//  Created by echo on 2025/5/12.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Switch to the main view controller after a 2-second delay (display splash)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.switchToMainViewController()
        }
    }

    private func setupUI() {
        // App icon
        let imageView = UIImageView(image: UIImage(named: "Github_Icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)

        // App description label
        let label = UILabel()
        label.text = """
        本アプリは
        株式会社マネーフォワードの
        面接のために作成しました。
        """
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        // Layout constraints
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
            make.width.height.equalTo(120)
        }

        label.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func switchToMainViewController() {
        // Get the window and safely unwrap it using if let chain
        if let window = UIApplication.shared.windows.first {
            // Create the main view controller (UserListViewController)
            let rootVC = UserListViewController()
            // Create a UINavigationController with the main view controller as root
            let naviVC = UINavigationController(rootViewController: rootVC)
            
            // Set the UINavigationController as the root view controller for the window
            window.rootViewController = naviVC
            // Make the window key and visible
            window.makeKeyAndVisible()
        }
    }
}
