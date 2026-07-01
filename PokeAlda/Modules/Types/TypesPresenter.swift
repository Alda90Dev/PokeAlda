//
//  TypesPresenter.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 30/06/26.
//

import Foundation

protocol TypesPresenterInterface {
    var output: TypesPresenterOutput { get set }
    func presentTypes(with response: TypesResponse)
}

class TypesPresenter: TypesPresenterInterface {
    var output: TypesPresenterOutput = TypesPresenterOutput()
    
    func presentTypes(with response: TypesResponse) {
        output.displayTypes.send(response.results ?? [])
    }
}
