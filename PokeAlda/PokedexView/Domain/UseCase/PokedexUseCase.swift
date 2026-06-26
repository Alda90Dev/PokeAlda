//
//  PokedexUseCase.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import Foundation

protocol PokedexUseCaseInterface {
    func fetchData() async throws -> NetworkResult<[PokemonResult]>
}

final class PokedexUseCase: PokedexUseCaseInterface {
    private let repository: PokedexRepositoryInterface
    private var pokemon: Pokemon?
    
    init(repository: PokedexRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchData() async throws -> NetworkResult<[PokemonResult]> {
        let response = try await repository.fetchData()
        
        switch response {
        case .success(let pokemon):
            self.pokemon = pokemon
            return .success(data: pokemon?.results ?? [])
        case .failure(let error):
            return .failure(error: error)
        }
    }
}
