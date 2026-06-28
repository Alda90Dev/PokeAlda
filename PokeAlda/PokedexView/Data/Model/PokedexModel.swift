//
//  PokedexModel.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import Foundation

struct PokemonResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Pokemon]?
}

struct Pokemon: Codable, Hashable {
    let name: String?
    let url: String?
}

extension Pokemon {
    var id: String {
        return String(url?.split(separator: "/").last ?? "")
    }

    var urlImage: String {
        return "\(NetworkRouter.baseImageURLString)\(id).png"
    }
}
