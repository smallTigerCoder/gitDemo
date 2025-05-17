//
//  UserListRouter.swift
//  GitDemo
//
//  Created by echo on 2025/5/14.
//

import Foundation
import UIKit

class UserListRouter {
    static func pushUserDetail(
        from viewController: UIViewController,
        userName:String
    ) {
        let detaliVC = UserDetailViewController.init(userName: userName)
        viewController.navigationController?.pushViewController(detaliVC, animated: true)
    }
}
