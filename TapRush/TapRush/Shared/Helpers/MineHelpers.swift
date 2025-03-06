//
//  MineHelpers.swift
//  TapRush
//
//  Created by Adam Mitro on 3/4/25.
//

import Foundation
import SwiftUICore

class MineHelpers {
    func createMineObject(for mineName: MineNames) -> Mine {
        let probabilities = getGemProbabilities(name: mineName)
        let coordinates = getMineCoordinates(name: mineName)
        return Mine(coordinates: coordinates, name: mineName, gemProbabilities: probabilities, primaryColor: .white, secondaryColor: .blue, rockSprites: [""])
    }
    
    func getGemProbabilities(name: MineNames) -> GemProbablity {
        switch name {
        case .dustveilQuarry: // 1
            return GemProbablity(gemsProbability: [.common: 0.5], noGemProbability: 0.5)
        case .amberHollow: // 1
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        case .whisperingCaverns: // 2
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        case .shadewindPassage: // 2
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        case .horizonRift: // 3
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        case .silvercoreDepths: // 3
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        case .shadowmarrowMine: // 4
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        case .blazewaterTunnels: // 4
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        case .azurefangChasm: // 4
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        case .celestiteExpanse: // 5
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        case .starstoneAbyss: // 5
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        case .astralcoreDepths: // 6
            return GemProbablity(gemsProbability: [.common: 0.6, .uncommon: 0.3], noGemProbability: 0.1)
        }
    }
    
    func getMineCoordinates(name: MineNames) -> (Int, Int) {
        switch name {
        case .dustveilQuarry: // 1
            return (100, 10)
        case .amberHollow: // 1
            return (30, 30)
        case .whisperingCaverns: // 2
            return (50, 50)
        case .shadewindPassage: // 2
            return (70, 70)
        case .horizonRift: // 3
            return (90, 90)
        case .silvercoreDepths: // 3
            return (110, 110)
        case .shadowmarrowMine: // 4
            return (120, 120)
        case .blazewaterTunnels: // 4
            return (130, 130)
        case .azurefangChasm: // 4
            return (140, 140)
        case .celestiteExpanse: // 5
            return (150, 150)
        case .starstoneAbyss: // 5
            return (160, 160)
        case .astralcoreDepths: // 6
            return (170, 170)
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

struct Mine {
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
