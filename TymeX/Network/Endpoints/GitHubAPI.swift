//
//  GitHubAPI.swift
//  TymeX
//
//  Created by Vinh Tran on 23/9/24.
//

import Foundation

/// Enumeration representing the various endpoints of the GitHub API used in this application
enum GitHubAPI {
    /// Fetches a list of GitHub users
    /// - Parameters:
    ///   - since: The integer ID of the last user that you've seen
    ///   - perPage: The number of results per page
    case users(since: Int, perPage: Int)
    
    /// Fetches detailed information about a specific GitHub user
    /// - Parameter username: The username of the GitHub user
    case userDetails(username: String)
}

extension GitHubAPI: APIEndpoint {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        case .userDetails(let username):
            return "/users/\(username)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .users, .userDetails:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .users(let since, let perPage):
            return [
                URLQueryItem(name: "since", value: "\(since)"),
                URLQueryItem(name: "per_page", value: "\(perPage)")
            ]
        case .userDetails:
            return nil
        }
    }
    
    var headers: [String: String]? {
        return [
            "Accept": "application/vnd.github.v3+json",
            "Content-Type": "application/json"
        ]
    }
}
