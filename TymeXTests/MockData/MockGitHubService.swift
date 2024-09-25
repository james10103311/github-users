//
//  MockGitHubService.swift
//  TymeXTests
//
//  Created by Vinh Tran on 24/9/24.
//

import Foundation
@testable import TymeX

actor MockGitHubService: ServiceProtocol {
    private var mockPaginatedResponse: PaginatedResponse<User>?
    private var mockUserDetails: UserDetails?
    private var shouldSucceed = true

    func setMockPaginatedResponse(_ response: PaginatedResponse<User>?) {
        self.mockPaginatedResponse = response
    }

    func setMockUserDetails(_ userDetails: UserDetails?) {
        self.mockUserDetails = userDetails
    }

    func setShouldSucceed(_ value: Bool) {
        self.shouldSucceed = value
    }

    func fetchUsersPaginated(since: Int, perPage: Int) async throws -> PaginatedResponse<User> {
        if shouldSucceed, let response = mockPaginatedResponse {
            return response
        } else {
            throw NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock fetch users error"])
        }
    }

    func fetchUserDetails(username: String) async throws -> UserDetails {
        if shouldSucceed, let userDetails = mockUserDetails {
            return userDetails
        } else {
            throw NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock fetch user details error"])
        }
    }
}
