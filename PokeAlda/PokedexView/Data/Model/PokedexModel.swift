//
//  PokedexModel.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import Foundation

struct Pokemon: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonResult]?
}

struct PokemonResult: Codable {
    let name: String?
    let url: String?
}
