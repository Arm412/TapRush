//
//  RockHelpers.swift
//  TapRush
//
//  Created by Adam Mitro on 1/4/25.
//

import Foundation

struct RockStates {
    let beginner: [String] = ["rockstates1", "rockstates2", "rockstates3", "rockstates4", "rockstates5", "rockstates6", "rockstates7", "rockstates8", "rockstates9"]
    let novice: [String] = ["rockstates1", "rockstates2", "rockstates3", "rockstates4", "rockstates5", "rockstates6", "rockstates7", "rockstates8", "rockstates9"]
    let advanced: [String] = ["rockstates1", "rockstates2", "rockstates3", "rockstates4", "rockstates5", "rockstates6", "rockstates7", "rockstates8", "rockstates9"]
    let proficient: [String] = ["rockstates1", "rockstates2", "rockstates3", "rockstates4", "rockstates5", "rockstates6", "rockstates7", "rockstates8", "rockstates9"]
    let expert: [String] = ["rockstates1", "rockstates2", "rockstates3", "rockstates4", "rockstates5", "rockstates6", "rockstates7", "rockstates8", "rockstates9"]
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
    var gemSprites: [String] = Gem().none
    
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
}

struct Gem {
    let none: [String] = []
    let common: [String] = ["purpEmerald1", "purpEmerald2"]
    let uncommon: [String] = ["purpEmerald1", "purpEmerald2"]
    let rare: [String] = ["purpEmerald1", "purpEmerald2"]
    let legendary: [String] = ["purpEmerald1", "purpEmerald2"]
}
