import Foundation
import SwiftUI

class MineHelpers {
    static let allMines: [Mine] = [
        Mine(gemProbabilities: getGemProbabilities(name: .dustveilQuarry), name: .dustveilQuarry,
             primaryColor: .gray, rockSprites: [], secondaryColor: .brown),
        
        Mine(gemProbabilities: getGemProbabilities(name: .amberHollow), name: .amberHollow,
             primaryColor: .orange, rockSprites: [], secondaryColor: .yellow),
        
        Mine(gemProbabilities: getGemProbabilities(name: .whisperingCaverns), name: .whisperingCaverns,
             primaryColor: .blue, rockSprites: [], secondaryColor: .purple),
        
        Mine(gemProbabilities: getGemProbabilities(name: .shadewindPassage), name: .shadewindPassage,
             primaryColor: .black, rockSprites: [], secondaryColor: .gray),
        
        Mine(gemProbabilities: getGemProbabilities(name: .horizonRift), name: .horizonRift,
             primaryColor: .red, rockSprites: [], secondaryColor: .white),
        
        Mine(gemProbabilities: getGemProbabilities(name: .silvercoreDepths), name: .silvercoreDepths,
             primaryColor: .white, rockSprites: [], secondaryColor: .blue),
        
        Mine(gemProbabilities: getGemProbabilities(name: .shadowmarrowMine), name: .shadowmarrowMine,
             primaryColor: .purple, rockSprites: [], secondaryColor: .black),
        
        Mine(gemProbabilities: getGemProbabilities(name: .blazewaterTunnels), name: .blazewaterTunnels,
             primaryColor: .orange, rockSprites: [], secondaryColor: .red),
        
        Mine(gemProbabilities: getGemProbabilities(name: .azurefangChasm), name: .azurefangChasm,
             primaryColor: .cyan, rockSprites: [], secondaryColor: .blue),
        
        Mine(gemProbabilities: getGemProbabilities(name: .celestiteExpanse), name: .celestiteExpanse,
             primaryColor: .white, rockSprites: [], secondaryColor: .green),
        
        Mine(gemProbabilities: getGemProbabilities(name: .starstoneAbyss), name: .starstoneAbyss,
             primaryColor: .white, rockSprites: [], secondaryColor: .black),
        
        Mine(gemProbabilities: getGemProbabilities(name: .astralcoreDepths), name: .astralcoreDepths,
             primaryColor: .purple, rockSprites: [], secondaryColor: .white)
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
    var gemProbabilities: GemProbability
    var isActive: Bool = false
    var name: MineNames
    var primaryColor: Color
    var rockSprites: [String]
    var secondaryColor: Color
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
