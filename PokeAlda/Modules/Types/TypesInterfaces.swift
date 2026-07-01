//
//  TypesInterfaces.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 30/06/26.
//

import Combine

struct TypesInteractorInput {
    let fetchTypes = PassthroughSubject<Void, Never>()
}

struct TypesPresenterOutput {
    let displayTypes = PassthroughSubject<[TypeResult], Never>()
}
