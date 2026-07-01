//
//  NetworkEndpoints.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 18/10/25.
//

import Foundation

enum NetworkEndpoints {
    enum Get {
        case pokemon
        case type
        
        var path: NetworkRouter {
            switch self {
            case .pokemon:
                return NetworkRouter(path: "pokemon", method: .get)
            case .type:
                return NetworkRouter(path: "type", method: .get)
            }
        }
    }
}
