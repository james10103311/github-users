//
//  GitHubServiceTests.swift
//  TymeXTests
//
//  Created by Vinh Tran on 24/9/24.
//

import XCTest
@testable import TymeX

class GitHubServiceTests: XCTestCase {
    var mockNetworkService: MockNetworkService!
    var githubService: GitHubService!
    var mockUsersData: Data!
    var mockUserDetailsData: Data!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkService = MockNetworkService()
        githubService = GitHubService(networkService: mockNetworkService)
        mockUsersData = try loadJSONData(filename: "ListUser")
        mockUserDetailsData = try loadJSONData(filename: "UserDetails")
    }
    
    override func tearDownWithError() throws {
        mockNetworkService = nil
        githubService = nil
        mockUsersData = nil
        try super.tearDownWithError()
    }
    
    func testFetchUsersPaginated() async throws {
        mockNetworkService.mockResult = .success(mockUsersData)
        
        let result = try await githubService.fetchUsersPaginated(since: 0, perPage: 20)
        
        XCTAssertEqual(result.items.count, 2)
        XCTAssertEqual(result.items[0].login, "defunkt")
        XCTAssertEqual(result.items[0].id, 2)
        XCTAssertEqual(result.items[0].avatarUrl, "https://avatars.githubusercontent.com/u/2?v=4")
        XCTAssertEqual(result.items[1].login, "pjhyett")
        XCTAssertEqual(result.items[1].id, 3)
        XCTAssertEqual(result.items[1].avatarUrl, "https://avatars.githubusercontent.com/u/3?v=4")
        XCTAssertEqual(result.nextSince, 3)
        
        let capturedEndpoint = try XCTUnwrap(mockNetworkService.capturedEndpoint as? GitHubAPI)
        if case .users(let since, let perPage) = capturedEndpoint {
            XCTAssertEqual(since, 0)
            XCTAssertEqual(perPage, 20)
        } else {
            XCTFail("Unexpected endpoint")
        }
    }
    
    func testFetchUserDetails() async throws {
        mockNetworkService.mockResult = .success(mockUserDetailsData)
        
        let result = try await githubService.fetchUserDetails(username: "mojombo")
        
        XCTAssertEqual(result.login, "mojombo")
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.avatarUrl, "https://avatars.githubusercontent.com/u/1?v=4")
        XCTAssertEqual(result.name, "Tom Preston-Werner")
        XCTAssertEqual(result.company, "@chatterbugapp, @redwoodjs, @preston-werner-ventures ")
        XCTAssertEqual(result.location, "San Francisco")
        XCTAssertEqual(result.publicRepos, 66)
        XCTAssertEqual(result.followers, 24019)
        XCTAssertEqual(result.following, 11)
        
        let capturedEndpoint = try XCTUnwrap(mockNetworkService.capturedEndpoint as? GitHubAPI)
        if case .userDetails(let username) = capturedEndpoint {
            XCTAssertEqual(username, "mojombo")
        } else {
            XCTFail("Unexpected endpoint")
        }
    }
    
    func testFetchUsersPaginatedFailure() async {
        let mockError = NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        mockNetworkService.mockResult = .failure(mockError)
        
        do {
            _ = try await githubService.fetchUsersPaginated(since: 0, perPage: 20)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, "TestError")
        }
    }
    
    func testFetchUserDetailsFailure() async {
        let mockError = NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Network error"])
        mockNetworkService.mockResult = .failure(mockError)
        
        do {
            _ = try await githubService.fetchUserDetails(username: "testuser")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual((error as NSError).domain, "TestError")
        }
    }
    
    // Helper function to load JSON data from a file
    private func loadJSONData(filename: String) throws -> Data {
        guard let url = Bundle(for: type(of: self)).url(forResource: filename, withExtension: "json") else {
            throw NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])
        }
        return try Data(contentsOf: url)
    }
}

