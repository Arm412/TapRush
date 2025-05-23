//
//  GemHelpers.swift
//  TapRush
//
//  Created by Adam Mitro on 3/2/25.
//

import Foundation

class GemHelpers {
    static let gemSprites: [GemType: [String]] = [
        .common: ["purpEmerald1"],
        .uncommon: ["purpEmerald2"],
        .rare: ["sapphire"],
        .legendary: ["emerald"],
        .mythical: ["diamond"]
    ]
    
    static func getGemIcon(for gemType: GemType) -> String {
        return gemSprites[gemType]?.first ?? ""
    }
}

struct Gem: Hashable {
    var count: Int = 0
    let icon: String
    let name: String
    let type: GemType
    let sprites: [String]
    var probability: Double = 0.0
    
    init(type: GemType) {
        self.type = type
        
        self.name = type.rawValue
        self.sprites = GemHelpers.gemSprites[type] ?? []
        self.icon = self.sprites.first ?? ""
    }
}

struct SoldGemCounts {
    var common: Gem = Gem(type: .common)
    var uncommon: Gem = Gem(type: .uncommon)
    var rare: Gem = Gem(type: .rare)
    var legendary: Gem = Gem(type: .legendary)
    var mythical: Gem = Gem(type: .mythical)
}

enum GemType: String, CaseIterable {
    case common = "common"
    case uncommon = "uncommon"
    case rare = "rare"
    case legendary = "legendary"
    case mythical = "mythical"
}
