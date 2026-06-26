//
//  PokedexService.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import Foundation

protocol PokedexServiceInterface {
    func fetchData() async throws -> NetworkResult<String>
}

final class PokedexService: PokedexServiceInterface {
    private let data: String = "Pokedex Service Data"
    
    func fetchData() async throws -> NetworkResult<String> {
        return .success(data: data)
    }
}
