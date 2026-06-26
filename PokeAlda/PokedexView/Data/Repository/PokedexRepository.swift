//
//  PokedexRepository.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import Foundation

protocol PokedexRepositoryInterface {
    func fetchData() async throws -> NetworkResult<String>
}

final class PokedexRepository: PokedexRepositoryInterface {
    private let service: PokedexServiceInterface
    
    init(service: PokedexServiceInterface) {
        self.service = service
    }
    
    func fetchData() async throws -> NetworkResult<String> {
        try await service.fetchData()
    }
}
