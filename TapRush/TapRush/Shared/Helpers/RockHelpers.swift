//
//  RockHelpers.swift
//  TapRush
//
//  Created by Adam Mitro on 1/4/25.
//

import Foundation

struct RockStates {
    let beginner: [String] = ["rockstates1", "rockstates2", "rockstates3", "rockstates4", "rockstates5"]
    let novice: [String] = ["rockstates1", "rockstates2", "rockstates3", "rockstates4", "rockstates5"]
    let advanced: [String] = ["rockstates1", "rockstates2", "rockstates3", "rockstates4", "rockstates5"]
    let proficient: [String] = ["rockstates1", "rockstates2", "rockstates3", "rockstates4", "rockstates5"]
    let expert: [String] = ["rockstates1", "rockstates2", "rockstates3", "rockstates4", "rockstates5"]
}

enum RockType{
    case beginner
    case novice
    case advanced
    case proficient
    case expert
}

struct Rock: Identifiable {
    let id: UUID
    var position: CGPoint
    var states: [String]
    var stateIndex: Int = 0
    var gemSprites: [String] = []
    var gemType: GemType = .none
    var isDepleted = false
    var hasGem = true
    var animationTimer: Timer? = nil
    var dust: DustCloud = DustCloud()
    var dustSettled = false
    
    init(id: UUID, position: CGPoint, rockType: RockType) {
        let rockStates = RockStates()
        
        self.id = id
        self.position = position
        
        switch rockType {
            case .beginner:
            self.states = rockStates.beginner
            break
            case .novice:
            self.states = rockStates.beginner
            break
            case .advanced:
            self.states = rockStates.beginner
            break
            case .proficient:
            self.states = rockStates.beginner
            break
            case .expert:
            self.states = rockStates.beginner
            break
            }
    }
    
    mutating func stopAnimation() {
        print("Invalidate")
        animationTimer?.invalidate()
        animationTimer = nil
    }
    
    mutating func determineGem() {
        let randomNumber = Int.random(in: 1...100)
        if randomNumber < 75 {
            gemType = .common
            gemSprites = GemManager().getGemNames(for: .common)
        } else {
            gemSprites = GemManager().getGemNames(for: .none)
            hasGem = false
        }
    }
}

enum GemType {
    case none
    case common
    case uncommon
    case rare
    case legendary
    case mythical
}

struct GemManager {
    private let gemNames: [GemType: [String]] = [
        .none: [],
        .common: ["purpEmerald1", "purpEmerald2"],
        .uncommon: ["purpEmerald1", "purpEmerald2"],
        .rare: ["purpEmerald1", "purpEmerald2"],
        .legendary: ["purpEmerald1", "purpEmerald2"],
        .mythical: ["purpEmerald1", "purpEmerald2"]
    ]
    
    func getGemNames(for type: GemType) -> [String] {
        return gemNames[type] ?? []
    }
}


struct DustCloud {
    let dustCloudSprites = ["dustCloud1", "dustCloud2", "dustCloud1", "dustCloud2", "dustCloud1", "dustCloud2"]
    var spriteIndex = 0
}
