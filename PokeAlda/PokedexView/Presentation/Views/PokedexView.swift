//
//  PokedexView.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import SwiftUI

struct PokedexView<ViewModel>: View where ViewModel: PokedexViewModelInterface {
    @ObservedObject private var viewModel: ViewModel
    @State private var searchText = ""
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(.pokemon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 120)
                
                HStack(spacing: 16) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("",
                                  text: $searchText,  
                                  prompt: Text("Search Pokémon")
                                            .foregroundColor(.gray))
                    }
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                    .frame(height: 44)
                    .background(Color.white)
                    .cornerRadius(22)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "circle.lefthalf.filled")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.pokemons, id: \.self) { pokemon in
                            PokemonCardView(pokemon: pokemon)
                        }
                    }
                    .padding()
                }
            }
            .padding(.bottom, 40)
            .task {
                await fetchData()
            }
        }
    }
    
    private func fetchData() async {
        viewModel.fetchData()
    }
}
