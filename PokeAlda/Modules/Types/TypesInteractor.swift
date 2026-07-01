//
//  TypesInteractor.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 30/06/26.
//

import Combine

protocol TypesInteractorInterface {
    func bind(input: TypesInteractorInput) -> TypesPresenterOutput
}

class TypesInteractor: TypesInteractorInterface {
    private var presenter: TypesPresenterInterface
    private var worker: TypesWorkerInterface
    private var subscriptions = Set<AnyCancellable>()
    
    init(worker: TypesWorkerInterface, presenter: TypesPresenterInterface) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func bind(input: TypesInteractorInput) -> TypesPresenterOutput {
        input.fetchTypes.sink { [weak self] in
            self?.fetchTypes()
        }.store(in: &self.subscriptions)
        
        return presenter.output
    }
    
    private func fetchTypes() {
        Task {
            let response = try await worker.fetchTypes()
            switch response {
            case .success(let data):
                guard let data else { return }
                presenter.presentTypes(with: data)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
