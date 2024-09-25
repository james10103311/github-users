//
//  UserListViewModelTests.swift
//  TymeXTests
//
//  Created by Vinh Tran on 25/9/24.
//

import XCTest
@testable import TymeX

@MainActor
class UserListViewModelTests: XCTestCase {
    var viewModel: UserListViewModel!
    var mockGitHubService: MockGitHubService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockGitHubService = MockGitHubService()
        viewModel = UserListViewModel(mockGitHubService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockGitHubService = nil
        try super.tearDownWithError()
    }

    func testLoadMoreUsers() async throws {
        let mockUsers = [
            User(login: "mojombo", id: 1, avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4"),
            User(login: "defunkt", id: 2, avatarUrl: "https://avatars.githubusercontent.com/u/2?v=4")
        ]
        
        let mockResponse = PaginatedResponse(items: mockUsers, nextSince: 2)
        await mockGitHubService.setMockPaginatedResponse(mockResponse)

        await viewModel.loadMoreUsers()

        XCTAssertEqual(viewModel.users.count, 2)
        XCTAssertEqual(viewModel.users[0].login, "mojombo")
        XCTAssertEqual(viewModel.users[1].login, "defunkt")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.isLastPage)
    }

    func testLoadMoreUsersLastPage() async throws {
        let mockUsers = [User(login: "mojombo", id: 1, avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4")]
        let mockResponse = PaginatedResponse(items: mockUsers, nextSince: nil)
        await mockGitHubService.setMockPaginatedResponse(mockResponse)

        await viewModel.loadMoreUsers()

        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(viewModel.isLastPage)
    }

    func testLoadMoreUsersError() async throws {
        await mockGitHubService.setShouldSucceed(false)

        await viewModel.loadMoreUsers()

        XCTAssertTrue(viewModel.users.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.isLastPage)
    }
}
