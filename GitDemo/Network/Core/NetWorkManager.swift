//
//  NetWorkManager.swift
//  GitDemo
//
//  Created by echo on 2025/5/12.
//

import Foundation
import Alamofire


//  API endpoint for user list
let request_user = "https://api.github.com/users"
//  API endpoint for user detail (needs to append username)
let request_detail = "https://api.github.com/users/"
//  API endpoint for user repositories (needs to format with username)
let request_repos = "https://api.github.com/users/%@/repos"

let token = Bundle.main.object(forInfoDictionaryKey: "GITHUB_TOKEN") as? String ?? ""

/// This class is the central network manager, responsible for sending various types of requests,
/// including user list, user detail, and user repository requests.
///
/// It adopts the singleton pattern to ensure only one instance exists across the app,
/// enabling centralized management of shared properties such as authentication.
///
/// Each request is handled through a separate request object to:
/// - Reduce coupling and improve responsibility clarity
/// - Achieve high cohesion and better reusability
/// - Make API configurations easier to manage and extend
/// - Allow flexible control of concurrency per API if needed
class NetWorkManager {
    
    static let shared = NetWorkManager()
    private let session: Session
    
    private init() {
        let adapter = AuthRequestAdapter(token: token)
        let configuration = URLSessionConfiguration.default
        session = Session(
            configuration: configuration,
            interceptor: adapter as? RequestInterceptor
        )
    }
    
    func send<T: APIRequest>(_ request: T, completion: @escaping (Result<T.respondType, Error>) -> Void) {
        do {
            let urlRequest = try request.asURLRequest()
            session.request(urlRequest)
                .validate()
                .responseDecodable(of: T.respondType.self) { response in
                    completion(response.result.mapError { $0 as Error })
                }
        } catch {
            completion(.failure(error))
        }
    }
}

// MARK: - Request Adapter
/// RequestAdapter is responsible for injecting the "Authorization" header into each request.
final class AuthRequestAdapter: RequestAdapter {
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Uses the Bearer scheme
        completion(.success(request))
    }
}
