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
                Text("LOGO")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.yellow)
                
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
                        ForEach(viewModel.pokemons) { pokemon in
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

struct PokemonCardView: View {
    let pokemon: PokemonResult
    
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(colors: [.blue.opacity(0.4), .gray.opacity(0.2)],
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .frame(height: 130)
                .overlay {
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
            
            HStack {
                Text("Number")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Spacer()
                Text(pokemon.name.orEmpty)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.black)
            }
            .padding(10)
            .background(Color.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
