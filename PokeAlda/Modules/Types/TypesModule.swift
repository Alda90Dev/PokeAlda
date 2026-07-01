//
//  TypesModule.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 30/06/26.
//

import SwiftUI

struct TypesModule {
    static func create() -> some View {
        let worker = TypesWorker()
        let presenter = TypesPresenter()
        let interactor = TypesInteractor(worker: worker, presenter: presenter)
        let logic = TypesDisplayLogic(interactor: interactor)
        
        return TypesView(state: logic)
    }
}
