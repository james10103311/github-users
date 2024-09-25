//
//  NetworkError.swift
//  TymeX
//
//  Created by Vinh Tran on 23/9/24.
//

/// Enumeration of possible network-related errors
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
}
