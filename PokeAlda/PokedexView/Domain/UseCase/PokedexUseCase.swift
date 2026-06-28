//
//  PokedexUseCase.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import Foundation

protocol PokedexUseCaseInterface {
    func fetchData() async throws -> NetworkResult<[Pokemon]>
}

final class PokedexUseCase: PokedexUseCaseInterface {
    private let repository: PokedexRepositoryInterface
    private var pokemonResponse: PokemonResponse?
    
    init(repository: PokedexRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchData() async throws -> NetworkResult<[Pokemon]> {
        let response = try await repository.fetchData()
        
        switch response {
        case .success(let response):
            self.pokemonResponse = response
            return .success(data: response?.results ?? [])
        case .failure(let error):
            return .failure(error: error)
        }
    }
}
