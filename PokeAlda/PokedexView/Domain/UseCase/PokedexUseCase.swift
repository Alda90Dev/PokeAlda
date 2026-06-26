//
//  PokedexUseCase.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import Foundation

protocol PokedexUseCaseInterface {
    func fetchData() async throws -> NetworkResult<String>
}

final class PokedexUseCase: PokedexUseCaseInterface {
    private let repository: PokedexRepositoryInterface
    
    init(repository: PokedexRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchData() async throws -> NetworkResult<String> {
        try await repository.fetchData()
    }
}
