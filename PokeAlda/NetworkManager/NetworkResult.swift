//
//  NetworkResult.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 18/10/25.
//

import Foundation

enum NetworkResult<T> {
    case success(data: T)
    case failure(error: NetworkError)
}

enum NetworkErrorType: LocalizedError {
    case parseURLFail
    case invalidResponse
    case dataError
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .parseURLFail:
            return "Cannot initial URL object"
        case .invalidResponse:
            return "Invalid Response"
        case .dataError:
            return "Invalid Data"
        case .serverError:
            return "Internal Server Error"
        }
    }
}

struct NetworkError: Error {
    let error: Error
    let statusCode: Int
}
