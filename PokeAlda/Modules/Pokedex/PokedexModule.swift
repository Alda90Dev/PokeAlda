//
//  PokedexModule.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import Foundation

final class PokedexModule {
    static func create() -> PokedexView<PokedexViewModel> {
        PokedexView(viewModel: createPokedexViewModel())
    }
    
    static private func createPokedexViewModel() -> PokedexViewModel {
        PokedexViewModel(useCase: createPokedexUseCase())
    }
    
    static private func createPokedexUseCase() -> PokedexUseCase {
        PokedexUseCase(repository: createPokedexRepository())
    }
    
    static private func createPokedexRepository() -> PokedexRepository {
        PokedexRepository(service: createPokedexService())
    }
    
    static private func createPokedexService() -> PokedexService {
        PokedexService()
    }
}
