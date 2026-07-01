//
//  TypesDisplayLogic.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 30/06/26.
//

import SwiftUI
import Combine

protocol TypesDisplayLogicInterface {
    var types: [TypeResult] { get set }
    var interactorInput: TypesInteractorInput { get set }
}

class TypesDisplayLogic: ObservableObject, TypesDisplayLogicInterface {
    @Published var types: [TypeResult] = []
    
    var interactorInput: TypesInteractorInput = TypesInteractorInput()
    private var interactor: TypesInteractorInterface
    private var subscriptions = Set<AnyCancellable>()
    
    init(interactor: TypesInteractorInterface) {
        self.interactor = interactor
        bind()
    }
    
    private func bind() {
        let output = interactor.bind(input: interactorInput)
        
        output.displayTypes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.types = data
            }.store(in: &subscriptions)
    }
}
