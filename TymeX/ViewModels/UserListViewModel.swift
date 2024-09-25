//
//  UserListViewModel.swift
//  TymeX
//
//  Created by Vinh Tran on 23/9/24.
//

import Foundation

/// View model that manages the list of GitHub users and handles pagination
@MainActor
class UserListViewModel: ObservableObject {
    /// List of GitHub users currently loaded
    @Published private(set) var users: [User] = []

    /// Indicates whether the view model is currently loading data
    @Published private(set) var isLoading = false
    
    /// Error message if something goes wrong during data fetching
    @Published private(set) var error: String?
    
    /// Indicates whether all available users have been loaded
    @Published private(set) var isLastPage = false
    
    /// The GitHub service used to fetch user data
    private let service: ServiceProtocol
    
    /// The ID to use for fetching the next page of users
    private var nextSince: Int = 0
    
    /// The number of users to fetch per page
    private let perPage = 20
    
    /// Initializes new instance with the service used to fetch GitHub user data
    init(_ service: ServiceProtocol) {
        self.service = service
    }
    
    /// This method fetches the next page of users and appends them to the existing list.
    /// It also updates the `isLoading`, `error`, and `isLastPage` states as appropriate.
    func loadMoreUsers() async {
        guard !isLoading && !isLastPage else { return }
        
        isLoading = true
        error = nil
        
        do {
            let response = try await service.fetchUsersPaginated(since: nextSince, perPage: perPage)
            users.append(contentsOf: response.items)
            nextSince = response.nextSince ?? nextSince
            isLastPage = response.nextSince == nil
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    /// This method resets the pagination state and fetches the first page of users.
    /// It's typically used for pull-to-refresh functionality.
    func refreshUsers() async {
        nextSince = 0
        users.removeAll()
        isLastPage = false
        await loadMoreUsers()
    }
}
