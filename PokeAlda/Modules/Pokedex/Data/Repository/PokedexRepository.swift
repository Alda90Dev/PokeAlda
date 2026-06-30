//
//  PokedexRepository.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import Foundation

protocol PokedexRepositoryInterface {
    func fetchData() async throws -> NetworkResult<PokemonResponse?>
    func fetchData(with customizedURL: String) async throws -> NetworkResult<PokemonResponse?>
}

final class PokedexRepository: PokedexRepositoryInterface {
    private let service: PokedexServiceInterface
    
    init(service: PokedexServiceInterface) {
        self.service = service
    }
    
    func fetchData() async throws -> NetworkResult<PokemonResponse?> {
        try await service.fetchData()
    }
    
    func fetchData(with customizedURL: String) async throws -> NetworkResult<PokemonResponse?> {
        try await service.fetchData(with: customizedURL)
    }
}
