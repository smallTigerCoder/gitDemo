//
//  FetchUserReposRequest.swift
//  GitDemo
//
//  Created by echo on 2025/5/15.
//

import Foundation
import Alamofire

struct FetchUserReposRequest: APIRequest {
    typealias respondType = [UserRepoModel]
    var userName: String

    func asURLRequest() throws -> URLRequest {
        let urlString = String(format: request_repos, userName)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return try URLEncoding.default.encode(request, with: nil)
    }
}
