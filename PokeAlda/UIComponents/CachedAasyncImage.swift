//
//  CachedAasyncImage.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 28/06/26.
//

import SwiftUI

struct CachedAsyncImage<Content: View>: View {
    let url: URL?
    @ViewBuilder let content: (AsyncImagePhase) -> Content
    
    var body: some View {
        if let url = url,
           let cachedImage = ImageCacheManager.get(for: url) {
            content(.success(cachedImage))
        } else {
            AsyncImage(url: url) { phase in
                
                if case .success(let image) = phase, let url = url {
                    let renderer = ImageRenderer(content: image)
                    if let uiImage = renderer.uiImage {
                        let _ = ImageCacheManager.set(uiImage, for: url)
                    }
                }
                content(phase)
            }
        }
    }
}
