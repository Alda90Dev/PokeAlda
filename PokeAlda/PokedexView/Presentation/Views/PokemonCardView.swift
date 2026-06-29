//
//  PokemonCardView.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 28/06/26.
//

import SwiftUI

struct PokemonCardView: View {
    let pokemon: Pokemon
    
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
                    CachedAsyncImage(url: URL(string: pokemon.urlImage)) { phase in
                        if let image = phase.image {
                            image.resizable().scaledToFit()
                        } else if phase.error != nil {
                            Image(systemName: "photo")
                              .font(.largeTitle)
                              .foregroundStyle(.white)
                        } else {
                            ProgressView() // Loading placeholder
                        }
                    }
                }
            
            HStack {
                Text("#\(pokemon.id)")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Spacer()
                Text(pokemon.name)
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

