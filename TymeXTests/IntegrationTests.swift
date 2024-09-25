//
//  IntegrationTests.swift
//  TymeXTests
//
//  Created by Vinh Tran on 25/9/24.
//

import XCTest
@testable import TymeX

class IntegrationTests: XCTestCase {
    
    func testUserListIntegration() async throws {
        let expectation = XCTestExpectation(description: "Fetch users")
        
        let service = GitHubService()
        let viewModel = await UserListViewModel(service)
        
        await viewModel.loadMoreUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertFalse(viewModel.users.isEmpty, "Users should not be empty")
            XCTAssertNil(viewModel.error, "There should be no error")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 10)
    }
    
    func testUserDetailIntegration() async throws {
        let expectation = XCTestExpectation(description: "Fetch user details")
        
        let service = GitHubService()
        let viewModel = await UserDetailViewModel(service)
        
        await viewModel.loadUserDetails(username: "octocat")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(viewModel.userDetail, "User details should not be nil")
            XCTAssertNil(viewModel.error, "There should be no error")
            XCTAssertEqual(viewModel.userDetail?.login, "octocat", "Username should be octocat")
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 10)
    }
}
