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
    var gem: Gem?
    var isDepleted = false
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
        animationTimer?.invalidate()
        animationTimer = nil
    }
    
    mutating func determineGem() {
        let randomNumber = Int.random(in: 1...120)
        if randomNumber <= 20 {
            gem = Gem(type: .common)
        } else if randomNumber > 20 && randomNumber <= 40 {
            gem = Gem(type: .uncommon)
        } else if randomNumber > 40 && randomNumber <= 60 {
            gem = Gem(type: .rare)
        } else if randomNumber > 60 && randomNumber <= 80 {
            gem = Gem(type: .legendary)
        } else if randomNumber > 80 && randomNumber <= 100 {
            gem = Gem(type: .mythical)
        }
    }
}

enum GemType: String, CaseIterable {
    case common = "common"
    case uncommon = "uncommon"
    case rare = "rare"
    case legendary = "legendary"
    case mythical = "mythical"
}

struct DustCloud {
    let dustCloudSprites = ["dustCloud1", "dustCloud2", "dustCloud1", "dustCloud2", "dustCloud1", "dustCloud2"]
    var spriteIndex = 0
}
