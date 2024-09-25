//
//  MockNetworkService.swift
//  TymeXTests
//
//  Created by Vinh Tran on 24/9/24.
//

import Foundation
@testable import TymeX

class MockNetworkService: NetworkServiceProtocol {
    var mockResult: Result<Data, Error>?
    var capturedEndpoint: APIEndpoint?
    
    func request<T>(_ endpoint: APIEndpoint) async throws -> T where T : Decodable {
        capturedEndpoint = endpoint
        guard let result = mockResult else {
            throw NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No mock result set"])
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        case .failure(let error):
            throw error
        }
    }
}
