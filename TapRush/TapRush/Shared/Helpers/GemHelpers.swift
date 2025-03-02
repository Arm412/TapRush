//
//  GemHelpers.swift
//  TapRush
//
//  Created by Adam Mitro on 3/2/25.
//

import Foundation

struct Gem {
    let name: String
    let type: GemType
    let sprites: [String]
    
    init(type: GemType) {
        self.type = type
        
        self.name = type.rawValue
        self.sprites = self.gemNames[type] ?? []
    }
    
    private let gemNames: [GemType: [String]] = [
        .common: ["purpEmerald1"],
        .uncommon: ["purpEmerald2"],
        .rare: ["sapphire"],
        .legendary: ["emerald"],
        .mythical: ["diamond"]
    ]
}
