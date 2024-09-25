//
//  NetworkServiceProtocol.swift
//  TymeX
//
//  Created by Vinh Tran on 23/9/24.
//

import Foundation

/// Protocol defining the network service operations
protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
}
