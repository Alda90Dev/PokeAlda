//
//  PokedexService.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import Foundation

protocol PokedexServiceInterface {
    func fetchData() async throws -> NetworkResult<PokemonResponse?>
    func fetchData(with customizedURL: String) async throws -> NetworkResult<PokemonResponse?>
}

final class PokedexService: PokedexServiceInterface {
    
    func fetchData() async throws -> NetworkResult<PokemonResponse?> {
        let result: NetworkResult<PokemonResponse?> = try await NetworkManager.shared.request(with: NetworkEndpoints.Get.pokemon.path)
        return result
    }
    
    func fetchData(with customizedURL: String) async throws -> NetworkResult<PokemonResponse?> {
        let result: NetworkResult<PokemonResponse?> = try await NetworkManager.shared.request(with: NetworkRouter(customizedPath: customizedURL, 
                                                                                                                  method: .get))
        return result
    }
}
