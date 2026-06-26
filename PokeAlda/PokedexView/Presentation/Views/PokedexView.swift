//
//  PokedexView.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 26/06/26.
//

import SwiftUI

struct PokedexView<ViewModel>: View where ViewModel: PokedexViewModelInterface {
    
    @ObservedObject private var viewModel: ViewModel
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(viewModel.data)
        }
        .padding()
        .task {
            await fetchData()
        }
    }
    
    private func fetchData() async {
        viewModel.fetchData()
    }
}
