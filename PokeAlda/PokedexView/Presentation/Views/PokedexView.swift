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
                                            .foregroundColor(.gray)
                        )
                        .onChange(of: searchText) { _, newValue in
                            self.viewModel.filterPokemons(by: searchText)
                        }
                        .submitLabel(.search)
                        .onSubmit {
                            debugPrint("Submited")
                           // viewModel.search()
                        }
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
                
                listItemsView
            }
            .padding(.bottom, 40)
            .task {
                await loadData()
            }
        }
    }
    
    @ViewBuilder
    private var listItemsView: some View {
        ListItemsView(viewModel: viewModel.listItemsViewModel)
    }
    
    private func loadData() async {
        viewModel.loadData()
    }
}
