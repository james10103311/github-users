//
//  ServiceProtocol.swift
//  TymeX
//
//  Created by Vinh Tran on 23/9/24.
//

import Foundation

/// Protocol defining the operations for interacting with API
protocol ServiceProtocol: Actor {
    func fetchUsersPaginated(since: Int, perPage: Int) async throws -> PaginatedResponse<User>
    func fetchUserDetails(username: String) async throws -> UserDetails
}
