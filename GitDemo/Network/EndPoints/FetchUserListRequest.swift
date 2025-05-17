//
//  FetchUserListRequest.swift
//  GitDemo
//
//  Created by echo on 2025/5/12.
//

import Foundation
import Alamofire

struct FetchUserListRequest: APIRequest {

    typealias respondType = [UserModel]
    var since: Int
    var perpage: Int
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: request_user) else {
            throw URLError(.badURL)
        }
        let parameters: Parameters = ["since": since,"per_page": perpage]
        return try URLEncoding.default
            .encode(URLRequest(url: url), with: parameters)
    }
}

