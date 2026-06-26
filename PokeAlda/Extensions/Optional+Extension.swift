//
//  String+Extension.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 18/10/25.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? String()
    }
}
