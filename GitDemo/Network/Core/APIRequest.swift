//
//  APIRequest.swift
//  GitDemo
//
//  Created by echo on 2025/5/12.
//

import Foundation
import Alamofire

/// Defines a general protocol for all API requests.
/// Each request must specify a corresponding Decodable response type and a method to build a URLRequest.
protocol APIRequest {
    associatedtype respondType: Decodable
    func asURLRequest() throws -> URLRequest
}

/// Extension to provide a convenient initializer for URLRequest,
/// supporting automatic setup for GET and POST (or other) methods, headers, and parameters.
extension URLRequest {
    /// Initializes a URLRequest with given method, headers, and parameters.
    /// - Parameters:
    ///   - url: The base URL of the request.
    ///   - method: The HTTP method, e.g., GET, POST.
    ///   - headers: Optional headers to include in the request.
    ///   - parameters: Optional parameters to be encoded as query or body.
    init(url: URL, method: HTTPMethod, headers: [String: String] = [:], parameters: [String: Any]? = nil) {
        self.init(url: url)
        self.httpMethod = method.rawValue
        self.allHTTPHeaderFields = headers
        
        if let parameters = parameters {
            if method == .get {
                // Encode parameters into URL query string for GET requests
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                urlComponents?.queryItems = parameters.map {
                    URLQueryItem(name: $0.key, value: String(describing: $0.value))
                }
                self.url = urlComponents?.url ?? url
            } else {
                // Encode parameters into HTTP body for POST/PUT requests
                self.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
                setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
    }
}
