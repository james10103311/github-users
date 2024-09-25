//
//  GitHubService.swift
//  TymeX
//
//  Created by Vinh Tran on 23/9/24.
//

import Foundation

/// Service that interacts with the GitHub API to fetch user data
actor GitHubService: ServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    /// Fetches a paginated list of GitHub users
    /// - Parameters:
    ///   - since: The integer ID of the last user that you've seen. This is used for pagination
    ///   - perPage: The number of results per page
    /// - Returns: A `PaginatedResponse` containing a list of `User` objects and the next pagination cursor
    /// - Throws: An error if the network request fails or if the response cannot be decoded
    func fetchUsersPaginated(since: Int, perPage: Int) async throws -> PaginatedResponse<User> {
        let endpoint = GitHubAPI.users(since: since, perPage: perPage)
        return try await networkService.request(endpoint)
    }
    
    /// Fetches detailed information about a specific GitHub user
    /// - Parameter username: The username of the GitHub user
    /// - Returns: A `UserDetails` object containing detailed information about the user
    /// - Throws: An error if the network request fails or if the response cannot be decoded
    func fetchUserDetails(username: String) async throws -> UserDetails {
        let endpoint = GitHubAPI.userDetails(username: username)
        return try await networkService.request(endpoint)
    }
}
