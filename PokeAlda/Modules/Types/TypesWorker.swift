//
//  TypesWorker.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 30/06/26.
//

import Foundation

protocol TypesWorkerInterface {
    func fetchTypes() async throws -> NetworkResult<TypesResponse?>
}

class TypesWorker: TypesWorkerInterface {
    func fetchTypes() async throws -> NetworkResult<TypesResponse?> {
        let result: NetworkResult<TypesResponse?> = try await NetworkManager.shared.request(with: NetworkEndpoints.Get.type.path)
        return result
    }
}
