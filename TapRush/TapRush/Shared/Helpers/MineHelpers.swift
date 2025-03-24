import Foundation
import SwiftUI

class MineHelpers {
    static let allMines: [Mine] = [
        Mine(name: .dustveilQuarry,
             gemProbabilities: getGemProbabilities(name: .dustveilQuarry),
             primaryColor: .gray, secondaryColor: .brown, rockSprites: []),
        
        Mine(name: .amberHollow,
             gemProbabilities: getGemProbabilities(name: .amberHollow),
             primaryColor: .orange, secondaryColor: .yellow, rockSprites: []),
        
        Mine(name: .whisperingCaverns,
             gemProbabilities: getGemProbabilities(name: .whisperingCaverns),
             primaryColor: .blue, secondaryColor: .purple, rockSprites: []),
        
        Mine(name: .shadewindPassage,
             gemProbabilities: getGemProbabilities(name: .shadewindPassage),
             primaryColor: .black, secondaryColor: .gray, rockSprites: []),
        
        Mine(name: .horizonRift,
             gemProbabilities: getGemProbabilities(name: .horizonRift),
             primaryColor: .red, secondaryColor: .white, rockSprites: []),
        
        Mine(name: .silvercoreDepths,
             gemProbabilities: getGemProbabilities(name: .silvercoreDepths),
             primaryColor: .white, secondaryColor: .blue, rockSprites: []),
        
        Mine(name: .shadowmarrowMine,
             gemProbabilities: getGemProbabilities(name: .shadowmarrowMine),
             primaryColor: .purple, secondaryColor: .black, rockSprites: []),
        
        Mine(name: .blazewaterTunnels,
             gemProbabilities: getGemProbabilities(name: .blazewaterTunnels),
             primaryColor: .orange, secondaryColor: .red, rockSprites: []),
        
        Mine(name: .azurefangChasm,
             gemProbabilities: getGemProbabilities(name: .azurefangChasm),
             primaryColor: .cyan, secondaryColor: .blue, rockSprites: []),
        
        Mine(name: .celestiteExpanse,
             gemProbabilities: getGemProbabilities(name: .celestiteExpanse),
             primaryColor: .white, secondaryColor: .green, rockSprites: []),
        
        Mine(name: .starstoneAbyss,
             gemProbabilities: getGemProbabilities(name: .starstoneAbyss),
             primaryColor: .white, secondaryColor: .black, rockSprites: []),
        
        Mine(name: .astralcoreDepths,
             gemProbabilities: getGemProbabilities(name: .astralcoreDepths),
             primaryColor: .purple, secondaryColor: .white, rockSprites: [])
    ]
    
    static func getMine(for name: MineNames) -> Mine? {
        return allMines.first { $0.name == name }
    }
    
    static func getGemProbabilities(name: MineNames) -> GemProbability {
        switch name {
        case .dustveilQuarry:
            return GemProbability(gemsProbabilityList: [.common: 0.2, .uncommon: 0.2, .rare: 0.2, .legendary: 0.2, .mythical: 0.1], noGemProbability: 0.1)
        case .amberHollow, .whisperingCaverns, .shadewindPassage, .horizonRift, .silvercoreDepths,
             .shadowmarrowMine, .blazewaterTunnels, .azurefangChasm, .celestiteExpanse,
             .starstoneAbyss, .astralcoreDepths:
            return GemProbability(gemsProbabilityList: [.uncommon: 0.4, .rare: 0.2, .legendary: 0.2, .mythical: 0.1], noGemProbability: 0.1)
        }
    }
}

struct GemProbability {
    var gemsProbabilityList: [GemType: Double]
    var noGemProbability: Double
}

struct Mine: Identifiable {
    var id: UUID = UUID()
    var description: String = "Description"
    var name: MineNames
    var gemProbabilities: GemProbability
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
