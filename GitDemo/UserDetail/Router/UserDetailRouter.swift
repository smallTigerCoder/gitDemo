//
//  UserDetailRouter.swift
//  GitDemo
//
//  Created by echo on 2025/5/14.
//

import Foundation
import UIKit

class UserDetailRouter {
    static func pushUserStorage(with url: URL,
        from viewController: UIViewController) {
        let webViewController = RepoDetailViewController(url: url)
        viewController.navigationController?
            .pushViewController(webViewController, animated: true)
    }
}



