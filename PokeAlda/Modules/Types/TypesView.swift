//
//  TypesView.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 30/06/26.
//

import SwiftUI

struct TypesView: View {
    @ObservedObject var state: TypesDisplayLogic
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("TYPES")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(state.types, id: \.self) { type in
                            Text(type.name ?? "")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 80)
                                .background(Color.blue.opacity(0.8))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .padding()
                }
            }
            .padding(.bottom, 40)
            .task {
                await loadData()
            }
        }
    }
    
    private func loadData() async {
        state.interactorInput.fetchTypes.send()
    }
}

