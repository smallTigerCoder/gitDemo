//
//  AlertManager.swift
//  GitDemo
//
//  Created by echo on 2025/5/16.
//

import UIKit
import SnapKit

// Defines a singleton to manage alert displays.
class AlertManager {
    // Static instance to ensure only one instance exists globally.
    static let shared = AlertManager()

    // Private initializer to prevent external instantiation.
    private init() {}

    // Weak reference to the currently presenting view controller to avoid retain cycles.
    private weak var presentingViewController: UIViewController?

    // Displays a toast message.
    func showToast(message: String, duration: TimeInterval = 2.0, from viewController: UIViewController? = nil) {
        // Ensure UI operations are performed on the main thread.
        DispatchQueue.main.async {
            // Dismiss any existing toast before showing a new one.
            if let presentingViewController = self.presentingViewController {
                presentingViewController.dismiss(animated: false) {
                    self.showToast(message: message, duration: duration, from: viewController)
                }
                return
            }

            // Determine the view controller to present the toast from.
            let presentingVC = viewController ?? self.findTopMostViewController()

            // Create the toast label.
            let toastLabel = UILabel()
            toastLabel.text = message
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            toastLabel.textColor = .white
            toastLabel.textAlignment = .center
            toastLabel.layer.cornerRadius = 10
            toastLabel.clipsToBounds = true
            toastLabel.font = UIFont.systemFont(ofSize: 14)
            toastLabel.translatesAutoresizingMaskIntoConstraints = false

            // Add the toast label to the view.
            presentingVC?.view.addSubview(toastLabel)

            // Use SnapKit to set up constraints.
            toastLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview() // Center horizontally
                make.bottom.equalToSuperview().offset(-100) // 100 points from the bottom
                make.horizontalEdges.equalToSuperview().inset(20) // 20 points padding on both sides.
            }

            // Store the presenting view controller.
            self.presentingViewController = presentingVC

            // Remove the toast label after the specified duration.
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                toastLabel.removeFromSuperview()
                self.presentingViewController = nil // Clear the reference.
            }
        }
    }

    // Finds the top-most view controller.
    private func findTopMostViewController() -> UIViewController? {
        var topMostVC = UIApplication.shared.keyWindow?.rootViewController

        while let presentedVC = topMostVC?.presentedViewController {
            topMostVC = presentedVC
        }
        return topMostVC
    }
}
