//
//  MaterialEffect.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 20/10/25.
//

import SwiftUI

struct MaterialEffect: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
