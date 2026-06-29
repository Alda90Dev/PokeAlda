//
//  ImageCacheManager.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 28/06/26.
//

import SwiftUI

final class ImageCacheManager {
    private static let cache = NSCache<NSURL, UIImage>()
    
    static func get(for url: URL) -> Image? {
        if let uiImage = cache.object(forKey: url as NSURL) {
            return Image(uiImage: uiImage)
        }
        return nil
    }
    
    static func set(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
