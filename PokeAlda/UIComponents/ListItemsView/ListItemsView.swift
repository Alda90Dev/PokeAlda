//
//  ListItemsView.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 29/06/26.
//

import SwiftUI

public struct ListItemsView: View {
    @ObservedObject public var viewModel: ListItemsViewModel
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    public init(viewModel: ListItemsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.items, id: \.self) { pokemon in
                    PokemonCardView(pokemon: pokemon)
                        .onAppear {
                            if pokemon.id == viewModel.items.last?.id {
                                viewModel.loadMore()
                            }
                        }
                }
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .padding()
        }
    }
}
