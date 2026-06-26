//
//  PokedexViewModel.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import Foundation

protocol PokedexViewModelInterface: ObservableObject {
    var data: String { get set }
    func fetchData()
}

final class PokedexViewModel: PokedexViewModelInterface {
    @Published var data: String = ""
    private let useCase: PokedexUseCaseInterface
    
    init(useCase: PokedexUseCaseInterface) {
        self.useCase = useCase
    }
    
    @MainActor func fetchData() {
        Task {
            let response = try await useCase.fetchData()
            switch response {
            case .success(let data):
                self.data = data
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
