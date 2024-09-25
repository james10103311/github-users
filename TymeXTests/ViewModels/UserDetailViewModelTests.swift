//
//  UserDetailViewModelTests.swift
//  TymeXTests
//
//  Created by Vinh Tran on 25/9/24.
//

import XCTest
@testable import TymeX

@MainActor
class UserDetailViewModelTests: XCTestCase {
    var viewModel: UserDetailViewModel!
    var mockGitHubService: MockGitHubService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockGitHubService = MockGitHubService()
        viewModel = UserDetailViewModel(mockGitHubService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockGitHubService = nil
        try super.tearDownWithError()
    }

    func testLoadUserDetails() async throws {
        let mockUser = UserDetails(
            login: "mojombo",
            avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
            blog: "http://tom.preston-werner.com",
            location: "San Francisco",
            followers: 100,
            following: 50
        )
        
        await mockGitHubService.setMockUserDetails(mockUser)

        await viewModel.loadUserDetails(username: "mojombo")

        XCTAssertEqual(viewModel.userDetail?.login, "mojombo")
        XCTAssertEqual(viewModel.userDetail?.avatarUrl, "https://avatars.githubusercontent.com/u/1?v=4")
        XCTAssertEqual(viewModel.userDetail?.blog, "http://tom.preston-werner.com")
        XCTAssertEqual(viewModel.userDetail?.location, "San Francisco")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }

    func testLoadUserDetailsError() async throws {
        await mockGitHubService.setShouldSucceed(false)

        await viewModel.loadUserDetails(username: "testuser")

        XCTAssertNil(viewModel.userDetail)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.error)
    }
}
