//
//  TypesModel.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 30/06/26.
//

import Foundation

struct TypesResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [TypeResult]?
}

struct TypeResult: Codable, Hashable {
    let name: String?
    let url: String?
}
