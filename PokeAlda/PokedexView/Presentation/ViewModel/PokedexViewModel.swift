//
//  PokedexViewModel.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import SwiftUI
import Combine

protocol PokedexViewModelInterface: ObservableObject {
    var listItemsViewModel: ListItemsViewModel { get set }
    func loadData()
    func filterPokemons(by searchText: String)
    func loadNextData()
}

final class PokedexViewModel: PokedexViewModelInterface {
    @ObservedObject var listItemsViewModel: ListItemsViewModel = ListItemsViewModel()
    private var pokemons: [Pokemon] = []
    private var cancellables = Set<AnyCancellable>()
    private let useCase: PokedexUseCaseInterface
    
    init(useCase: PokedexUseCaseInterface) {
        self.useCase = useCase
        self.bind()
    }
    
    private func bind() {
        listItemsViewModel.loadMorePublisher.sink { [weak self] in
            self?.loadNextData()
        }.store(in: &cancellables)
    }
    
    @MainActor func loadData() {
        Task {
            let response = try await useCase.fetchData()
            switch response {
            case .success(let data):
                self.listItemsViewModel.items =  data
                self.pokemons = data
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func filterPokemons(by searchText: String) {
        if searchText.isEmpty {
            listItemsViewModel.items = pokemons
            return
        }
        listItemsViewModel.items = pokemons.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    @MainActor func loadNextData() {
        Task {
            listItemsViewModel.isLoading = true
            let response = try await useCase.fecthNextData()
            listItemsViewModel.isLoading = false
            switch response {
            case .success(data: let data):
                self.listItemsViewModel.items.append(contentsOf: data)
                self.pokemons.append(contentsOf: data)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
