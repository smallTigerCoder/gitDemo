//
//  UserModel.swift
//  GitDemo
//
//  Created by echo on 2025/5/14.
//

import Foundation


struct UserModel: Decodable {
    let login: String?
    let avatar_url: String?
    let id: Int?
}
