//
//  UserDetailViewModel.swift
//  TymeX
//
//  Created by Vinh Tran on 24/9/24.
//

import Foundation

/// View model that manages the detailed information of a specific GitHub user.
@MainActor
class UserDetailViewModel: ObservableObject {
    /// Detailed information of the GitHub user
    @Published private(set) var userDetail: UserDetails?
    
    /// Indicates whether the view model is currently loading data
    @Published private(set) var isLoading = false
    
    /// Error message if something goes wrong during data fetching
    @Published private(set) var error: String?
    
    /// GitHub service used to fetch user data
    private let service: ServiceProtocol
    
    /// Initializes new instance with the service used to fetch GitHub user details data
    init(_ service: ServiceProtocol) {
        self.service = service
    }
    
    /// This method fetches the detailed information of a specific GitHub user and updates the `userDetail` property.
    /// It also manages the `isLoading` and `error` states during the process.
    func loadUserDetails(username: String) async {
        isLoading = true
        error = nil
        
        do {
            userDetail = try await service.fetchUserDetails(username: username)
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
}
