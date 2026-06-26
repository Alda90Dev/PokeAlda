//
//  NetworkManager.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 18/10/25.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let config: URLSessionConfiguration
    private let session: URLSession
    
    private init() {
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }

    public func request<T: Decodable> (with networkRouter: NetworkRouter) async throws -> NetworkResult<T> {
        do {
            let (data, response) = try await URLSession.shared.data(for: networkRouter.request())
            
            guard let statusCode = response.getStatusCode(), (200...299).contains(statusCode) else {
                let errorType: NetworkErrorType = .invalidResponse
                throw NetworkError(
                    error: errorType,
                    statusCode: response.getStatusCode() ?? 0)
            }
                    
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                return .success(data: result)
            } catch let error {
                throw NetworkError(error: error, statusCode: 200)
            }
            
        } catch {
            throw NetworkError(error: error, statusCode: 500)
        }
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        
        return nil
    }
}
