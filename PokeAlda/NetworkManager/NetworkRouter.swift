//
//  NetworkRouter.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 18/10/25.
//

import Foundation

struct NetworkRouter {
    let path: String?
    let customizedPath: String?
    let body: Encodable?
    let method: HTTPMethod
    
    private static let baseURLString: String = "https://pokeapi.co/api/v2/"
    
    var bodyData: Data? {
        guard let body = body else { return nil }
        do {
            let encodedData = try JSONEncoder().encode(body)
            return encodedData
        } catch {
            return nil
        }
    }
    
    init(path: String? = nil,
         customizedPath: String? = nil,
         body: Encodable? = nil,
         method: HTTPMethod) {
        self.path = path
        self.customizedPath = customizedPath
        self.body = body
        self.method = method
    }
    
    enum HTTPMethod {
        case get
        case post
        
        var value: String {
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            }
        }
    }
    
    func request() throws -> URLRequest {
        let urlPath = customizedPath ?? "\(NetworkRouter.baseURLString)\(path.orEmpty)"
        let urlString = urlPath
        
        guard let url = URL(string: urlString) else { throw NetworkErrorType.parseURLFail }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData
        
        return request
    }
}
