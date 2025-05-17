//
//  FetchUserDetailRequest.swift
//  GitDemo
//
//  Created by echo on 2025/5/15.
//

import Foundation
import Alamofire


struct FetchUserDetailRequest: APIRequest {
    typealias respondType = UserDetailModel
    var userName: String

    func asURLRequest() throws -> URLRequest {
        let urlString = request_detail + userName
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        return try URLEncoding.default
            .encode(URLRequest(url: url), with: nil)
    }
}
