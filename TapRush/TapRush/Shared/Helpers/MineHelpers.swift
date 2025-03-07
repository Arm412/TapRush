//
//  MineHelpers.swift
//  TapRush
//
//  Created by Adam Mitro on 3/4/25.
//

import Foundation
import SwiftUICore

class MineHelpers {
    static let allMines: [Mine] = [
        Mine(coordinates: (500, 500), name: .dustveilQuarry,
             gemProbabilities: getGemProbabilities(name: .dustveilQuarry),
             primaryColor: .gray, secondaryColor: .brown, rockSprites: []),
        
        Mine(coordinates: (30, 30), name: .amberHollow,
             gemProbabilities: getGemProbabilities(name: .amberHollow),
             primaryColor: .orange, secondaryColor: .yellow, rockSprites: []),
        
        Mine(coordinates: (50, 50), name: .whisperingCaverns,
             gemProbabilities: getGemProbabilities(name: .whisperingCaverns),
             primaryColor: .blue, secondaryColor: .purple, rockSprites: []),
        
        Mine(coordinates: (70, 70), name: .shadewindPassage,
             gemProbabilities: getGemProbabilities(name: .shadewindPassage),
             primaryColor: .black, secondaryColor: .gray, rockSprites: []),
        
        Mine(coordinates: (90, 90), name: .horizonRift,
             gemProbabilities: getGemProbabilities(name: .horizonRift),
             primaryColor: .red, secondaryColor: .white, rockSprites: []),
        
        Mine(coordinates: (110, 110), name: .silvercoreDepths,
             gemProbabilities: getGemProbabilities(name: .silvercoreDepths),
             primaryColor: .white, secondaryColor: .blue, rockSprites: []),
        
        Mine(coordinates: (120, 120), name: .shadowmarrowMine,
             gemProbabilities: getGemProbabilities(name: .shadowmarrowMine),
             primaryColor: .purple, secondaryColor: .black, rockSprites: []),
        
        Mine(coordinates: (130, 130), name: .blazewaterTunnels,
             gemProbabilities: getGemProbabilities(name: .blazewaterTunnels),
             primaryColor: .orange, secondaryColor: .red, rockSprites: []),
        
        Mine(coordinates: (140, 140), name: .azurefangChasm,
             gemProbabilities: getGemProbabilities(name: .azurefangChasm),
             primaryColor: .cyan, secondaryColor: .blue, rockSprites: []),
        
        Mine(coordinates: (150, 150), name: .celestiteExpanse,
             gemProbabilities: getGemProbabilities(name: .celestiteExpanse),
             primaryColor: .white, secondaryColor: .green, rockSprites: []),
        
        Mine(coordinates: (160, 160), name: .starstoneAbyss,
             gemProbabilities: getGemProbabilities(name: .starstoneAbyss),
             primaryColor: .white, secondaryColor: .black, rockSprites: []),
        
        Mine(coordinates: (170, 170), name: .astralcoreDepths,
             gemProbabilities: getGemProbabilities(name: .astralcoreDepths),
             primaryColor: .purple, secondaryColor: .white, rockSprites: [])
    ]
    
    static func getMine(for name: MineNames) -> Mine? {
        return allMines.first { $0.name == name }
    }
    
    static func getGemProbabilities(name: MineNames) -> GemProbablity {
        switch name {
        case .dustveilQuarry:
            return GemProbablity(gemsProbability: [.common: 0.5], noGemProbability: 0.5)
        case .amberHollow, .whisperingCaverns, .shadewindPassage, .horizonRift, .silvercoreDepths,
             .shadowmarrowMine, .blazewaterTunnels, .azurefangChasm, .celestiteExpanse,
             .starstoneAbyss, .astralcoreDepths:
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        }
    }
}


struct GemProbablity {
    var gemsProbability: [GemType:Double]
    var noGemProbability: Double
    
    init(gemsProbability: [GemType : Double], noGemProbability: Double) {
        self.gemsProbability = gemsProbability
        self.noGemProbability = noGemProbability
    }
}

struct Mine: Identifiable {
    var id: UUID = UUID()
    var coordinates: (Int, Int)
    var name: MineNames
    var gemProbabilities: GemProbablity
    var primaryColor: Color
    var secondaryColor: Color
    var rockSprites: [String]
}

enum MineNames: String, CaseIterable {
    case dustveilQuarry = "Dustveil Quarry"
    case amberHollow = "Amber Hollow"
    case whisperingCaverns = "Whispering Caverns"
    case shadewindPassage = "Shadewind Passage"
    case horizonRift = "Horizon Rift"
    case silvercoreDepths = "Silvercore Depths"
    case shadowmarrowMine = "Shadowmarrow Mine"
    case blazewaterTunnels = "Blazewater Tunnels"
    case azurefangChasm = "Azurefang Chasm"
    case celestiteExpanse = "Celestite Expanse"
    case starstoneAbyss = "Starstone Abyss"
    case astralcoreDepths = "Astralcore Depths"
}
