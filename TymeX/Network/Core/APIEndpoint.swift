//
//  Untitled.swift
//  TymeX
//
//  Created by Vinh Tran on 23/9/24.
//

import Foundation

/// Protocol defining the structure of an API endpoint
protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
}
